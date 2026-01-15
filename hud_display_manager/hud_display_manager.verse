# ----------------------------------------------
# Documentation: https://uecreators.com/hud-message-verse
# ----------------------------------------------

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# トリガーを踏むと、画面にメッセージを表示するデバイス
hud_display_manager := class(creative_device):

    # 1. メッセージを表示する仕掛け（HUD Message）
    # エディタで「ようこそ！」「危険エリア！」などの文字を設定します
    @editable
    MyMessage : hud_message_device = hud_message_device{}

    # 2. きっかけとなるトリガー（床に置くタイプ）
    # プレイヤーがこれを踏むとメッセージが出ます
    @editable
    MessageTrigger : trigger_device = trigger_device{}

    # ゲーム開始時の処理
    OnBegin<override>()<suspends>:void=
        # トリガーが踏まれた（Triggered）時のイベントを登録
        MessageTrigger.TriggeredEvent.Subscribe(OnTriggerActivated)

    # トリガーが踏まれた時に実行される関数
    OnTriggerActivated(MaybeAgent : ?agent):void=
        # Triggerは「?agent（空かもしれない）」を送ってくる可能性があるため、
        # if式で「本当にプレイヤー(Agent)がいるか？」を確認します
        if (Agent := MaybeAgent?):
            # プレイヤーが確認できたら、その人だけにメッセージを表示
            MyMessage.Show(Agent)