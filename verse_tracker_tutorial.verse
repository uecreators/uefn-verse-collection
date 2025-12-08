using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# ドキュメントに基づいた、基本的なトラッカー制御デバイス
verse_tracker_tutorial := class(creative_device):

    # トラッカーの仕掛け（目標管理）
    @editable
    MyTracker : tracker_device = tracker_device{}

    # テスト用のボタン仕掛け（これを押すと目標値が加算される）
    @editable
    MyButton : button_device = button_device{}

    OnBegin<override>()<suspends>:void=
        # 1. ゲーム開始時に、全プレイヤーにトラッカーを表示する
        # Assign(Agent) の使用例
        for(Player : GetPlayspace().GetPlayers()):
            MyTracker.Assign(Player)

        # 2. イベントの登録
        # ボタンが押されたら OnButtonInteracted を実行
        MyButton.InteractedWithEvent.Subscribe(OnButtonInteracted)
        # 目標を達成したら OnQuestCompleted を実行
        MyTracker.CompleteEvent.Subscribe(OnQuestCompleted)

    # ボタンを押した時の処理
    OnButtonInteracted(Agent:agent):void=
        # Increment(Agent) の使用例
        # デフォルトでは目標値が「1」加算される
        MyTracker.Increment(Agent)
        Print("クエスト目標値が 1 増えました")

    # クエスト達成時の処理
    OnQuestCompleted(Agent:agent):void=
        Print("おめでとうございます！クエストクリアです！")