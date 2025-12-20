# ----------------------------------------------
# Documentation: https://uecreators.com/input-trigger-verse
# ----------------------------------------------

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 入力トリガーを使って「押している間だけ」反応するデバイス
input_action_manager := class(creative_device):

    # 1. 入力トリガーの仕掛け
    # エディタ側で「入力（Input）」を「Target（照準）」などに設定しておきます
    @editable
    MyInputTrigger : input_trigger_device = input_trigger_device{}

    # 2. 反応させるライト（演出用）
    @editable
    StatusLight : customizable_light_device = customizable_light_device{}

    # ゲーム開始時の処理
    OnBegin<override>()<suspends>:void=
        # ボタンを「押した瞬間」のイベント登録
        MyInputTrigger.PressedEvent.Subscribe(OnInputPressed)

        # ボタンを「離した瞬間」のイベント登録
        # ※注意：離した時のイベントは、少し特殊なデータを受け取ります
        MyInputTrigger.ReleasedEvent.Subscribe(OnInputReleased)

    # ボタンを押した時の処理
    # ここはいつも通り、Agent（押した人）が渡されます
    OnInputPressed(Agent:agent):void=
        Print("ボタンを長押し中：警戒モードON")
        StatusLight.TurnOn() # ライトを点ける

    # ボタンを離した時の処理
    # 【重要】ReleasedEventは「誰が(Agent)」と「何秒押したか(float)」の
    # 2つのデータがセット(tuple)になって送られてきます
    OnInputReleased(Args : tuple(agent, float)):void=
        # Args(引数)の中から、1つ目のデータ(Agent)を取り出します
        # 「Args」は「Argument(s) 引数の複数形」の略称として名前付けしています
        Agent := Args(0)
        # 2つ目のデータ(押していた時間)を取り出します
        # Tuple typeのデータは()内にインデックス番号を入力することで取り出し可能
        Duration := Args(1)

        Print("ボタンを離しました。押していた時間：{Duration}秒")
        StatusLight.TurnOff() # ライトを消す