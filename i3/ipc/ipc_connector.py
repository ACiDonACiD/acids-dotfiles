# ipc_connector.py

from i3ipc import Connection, Event
import os

def main(): 
    SOCKET = os.getenv("I3SOCK")
    try:
        i3 = Connection(socket_path=SOCKET, auto_reconnect=True)
        print(f"Connected")
    except Exception as E:
        print(f"ERROR: {E}")
        return(1)

    print(i3)

if __name__ == "__main__":
    main()
