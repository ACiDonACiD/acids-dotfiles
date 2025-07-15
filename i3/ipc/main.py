from i3ipc import Connection, Event

def main():
    ipc = Connection(auto_reconnect=True)
    print(ipc)

if __name__ == "__main__":
    main()
