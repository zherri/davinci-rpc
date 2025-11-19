import time
import sys
from pypresence import Presence, DiscordNotFound, InvalidID
import DaVinciResolveScript as dvr

CLIENT_ID = "1440756413520543886"  # Discord application's client ID
UPDATE_INTERVAL = 5  # seconds


def connect_discord():
    """Connects to Discord RPC, keeps retrying until Discord is open."""
    while True:
        try:
            rpc = Presence(CLIENT_ID)
            rpc.connect()
            print("[INFO] Connected to Discord RPC.")
            return rpc
        except (DiscordNotFound, InvalidID):
            print("[WARN] Discord not detected. Retrying in 5s...")
            time.sleep(5)


def get_resolve():
    """Tries to connect to DaVinci Resolve. Exits if not found."""
    resolve = dvr.scriptapp("Resolve")
    if not resolve:
        print("[ERROR] DaVinci Resolve not found. Exiting...")
        sys.exit(0)
    return resolve


def resolve_is_alive(resolve):
    """Checks if Resolve is still running."""
    try:
        # Attempt to access something lightweight
        pm = resolve.GetProjectManager()
        if pm is None:
            return False
        pm.GetCurrentProject()  # Touch something to verify
        return True
    except:
        return False


def update_presence(rpc, resolve):
    """Updates Discord Rich Presence according to Resolve state."""
    try:
        project_manager = resolve.GetProjectManager()
        project = project_manager.GetCurrentProject()

        if not project:
            rpc.update(
                details="Idle",
                state="No open project",
                large_image="davinci_resolve_logo",
                large_text="DaVinci Resolve Studio",
            )
            return

        timeline = project.GetCurrentTimeline()
        project_name = project.GetName()

        if timeline:
            timeline_name = timeline.GetName()
            status_details = f"Editing: {timeline_name}"
        else:
            status_details = "In Project"

        status_state = f"Project: {project_name}"

        rpc.update(
            details=status_details,
            state=status_state,
            large_image="davinci_resolve_logo",
            large_text="DaVinci Resolve Studio",
        )

    except Exception as e:
        print(f"[ERROR] Failed updating RPC: {e}")
        raise  # handled in main loop


def main():
    print("[INFO] Starting DaVinci Discord RPC...")

    rpc = connect_discord()
    resolve = get_resolve()

    while True:
        # If Resolve is closed -> stop
        if not resolve_is_alive(resolve):
            print("[INFO] DaVinci Resolve closed. Exiting...")
            try:
                rpc.clear()
            except:
                pass
            sys.exit(0)

        # Try updating RPC
        try:
            update_presence(rpc, resolve)
        except DiscordNotFound:
            print("[WARN] Discord closed. Reconnecting...")
            rpc = connect_discord()
        except Exception as e:
            print(f"[ERROR] Unexpected RPC error: {e}")
            sys.exit(1)

        time.sleep(UPDATE_INTERVAL)


if __name__ == "__main__":
    main()
