# ----------------------------------------------
# Documentation: https://uecreators.com/lock-device-verse
# ----------------------------------------------

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 条件付きボタンを使ってドアのロックを解除するデバイス
door_lock_manager := class(creative_device):

    # 制御対象の「lock_device」（ドアにアタッチされているもの）
    @editable
    MyLock : lock_device = lock_device{}

    # 鍵アイテムを要求する「conditional_button」
    # エディタ側で、必要なアイテム（鍵）を設定しておきます
    @editable
    KeyButton : conditional_button_device = conditional_button_device{}

    # ゲーム開始時の処理
    OnBegin<override>()<suspends>:void=
        # ボタンの「起動（条件クリア）」イベントを登録
        # プレイヤーが正しいアイテムを持ってconditional_buttonを押すと作動します
        KeyButton.ActivatedEvent.Subscribe(OnKeyUsed)

    # 鍵（アイテム）を使ってボタンが押された時に実行される関数
    # 引数(Agent)には、ボタンを押したプレイヤーの情報が入ってきます
    OnKeyUsed(Agent:agent):void=
        Print("鍵を確認。ロックを解除します。")

        # 1. 鍵を開ける（Unlock）
        # 引数(Agent)を渡すことで、「誰が開けたか」をlock_deviceに伝えます
        MyLock.Unlock(Agent)

        # 2. ドアを開放する（Open）
        # 親切設計。物理的にドアを開き、プレイヤーを通れるようにします
        MyLock.Open(Agent)