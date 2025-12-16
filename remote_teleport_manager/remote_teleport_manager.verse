# ----------------------------------------------
# Documentation: https://uecreators.com/signal-remote-verse
# ----------------------------------------------

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 信号リモコンを使って、2つの地点を行き来するデバイス
remote_teleport_manager := class(creative_device):

    # 1. 信号リモコンマネージャー
    # ゲーム内でプレイヤーが持つリモコンと同じ「レアリティ」に設定してください
    @editable
    MyRemoteManager : signal_remote_manager_device = signal_remote_manager_device{}

    # 2. メインボタンで移動する先（A地点）
    # 例：自宅、ロビーなど
    @editable
    TeleporterA : teleporter_device = teleporter_device{}

    # 3. サブボタンで移動する先（B地点）
    # 例：採掘場、農場など
    @editable
    TeleporterB : teleporter_device = teleporter_device{}

    # ゲーム開始時の処理
    OnBegin<override>()<suspends>:void=
        # メインボタン（左クリック/射撃）が押された時のイベントを登録
        # 押されたら、A地点へ移動する関数（GoToLocationA）を実行します
        MyRemoteManager.PrimarySignalEvent.Subscribe(GoToLocationA)

        # サブボタン（右クリック/照準）が押された時のイベントを登録
        # 押されたら、B地点へ移動する関数（GoToLocationB）を実行します
        MyRemoteManager.SecondarySignalEvent.Subscribe(GoToLocationB)

    # A地点（メインの行き先）へ転送する関数
    GoToLocationA(Agent:agent):void=
        Print("メインボタン検知：A地点へ転送します。")
        # リモコンを押した本人（Agent）を、TeleporterAの位置へ移動させます
        TeleporterA.Teleport(Agent)

    # B地点（サブの行き先）へ転送する関数
    GoToLocationB(Agent:agent):void=
        Print("サブボタン検知：B地点へ転送します。")
        # リモコンを押した本人（Agent）を、TeleporterBの位置へ移動させます
        TeleporterB.Teleport(Agent)