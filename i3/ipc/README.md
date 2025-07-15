PROCESSING STATES (client + server)
    Independent ( Does not interact with other processes )
    Cooperating ( Shares data with other processes ) - IPC
        - Shared Data(Prone to error)
        - Message Passing(Safer) - uses pipes/sockets/RPC


USE CASES:
    - Infomation sharing
    - Computation speedup

Events:
    - Window
    - Window New
    - Window Close
    - Window Focus
    - Window Move
    - Window Floating
    - Window Fullscreen Mode
    - Window Mark
        \
    WORKSPACE = 'workspace'
    WORKSPACE_EMPTY = 'workspace::empty'
    WORKSPACE_FOCUS = 'workspace::focus'
    WORKSPACE_INIT = 'workspace::init'¶
    WORKSPACE_MOVE = 'workspace::move'
    WORKSPACE_RELOAD = 'workspace::reload'
    WORKSPACE_RENAME = 'workspace::rename'
    WORKSPACE_RESTORED = 'workspace::restored'


