# ----------------------------------------------
# Documentation: https://uecreators.com/popup-dialog-verse
# ----------------------------------------------

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# プレイヤーに選択肢（OK/Cancel）を提示するデバイス
popup_dialog_manager := class(creative_device):

    # 1. ポップアップダイアログ
    # エディタで「ボタン1：OK」「ボタン2：Cancel」と設定しておきます
    @editable
    QuestDialog : popup_dialog_device = popup_dialog_device{}

    # 2. きっかけとなるボタン
    @editable
    TalkButton : button_device = button_device{}

    # ゲーム開始時の処理
    OnBegin<override>()<suspends>:void=
        # 会話ボタンが押されたら、ダイアログを表示
        TalkButton.InteractedWithEvent.Subscribe(ShowDialog)

        # ダイアログのボタンが押された（返事があった）時のイベント登録
        QuestDialog.RespondingButtonEvent.Subscribe(OnDialogResponded)

    # ダイアログを表示する
    ShowDialog(Agent:agent):void=
        # 特定のプレイヤーにだけ表示する
        QuestDialog.Show(Agent)

    # プレイヤーが「OK」か「Cancel」を選んだ時の処理
    # 引数は Tuple(誰が, 何番のボタンか) で送られてきます
    OnDialogResponded(Result : tuple(agent, int)):void=
        Agent := Result(0) # 誰が
        ButtonIndex := Result(1) # 何番のボタンを押したか (0, 1, 2...)

        # エディタのボタン設定順序によって番号が決まります
        # 今回は「ボタン1(Index 0)」を「OK」と想定します
        if (ButtonIndex = 0):
            Print("クエストを受注しました！")
            # ここにアイテムをあげる処理などを追加できます
        else:
            Print("クエストを断りました。")