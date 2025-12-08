
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# トリックタイル制御クラス
trick_tile_manager := class(creative_device):

    # エディタで割り当てる仕掛け
    @editable
    MyTrickTile : trick_tile_device = trick_tile_device{}

    @editable
    MyTrigger : trigger_device = trigger_device{}

    # ゲーム開始時の処理
    OnBegin<override>()<suspends>:void=
        # トリガーが踏まれたら、OnTriggered関数を実行するように登録
        MyTrigger.TriggeredEvent.Subscribe(OnTriggered)

    # トリガーが起動した時の処理
    OnTriggered(MaybeAgent : ?agent) : void =
        # 非同期処理（時間を扱う処理）を開始
        spawn{ ActivateAndReset() }

    # タイルを消して、復活させる処理
    ActivateAndReset()<suspends> : void =
        # 1. タイルを起動（消す・破壊する）
        MyTrickTile.Trigger()
        
        # 2. 5秒待機する
        Sleep(5.0)

        # 3. タイルをリセット（復活させる）
        MyTrickTile.Reset()