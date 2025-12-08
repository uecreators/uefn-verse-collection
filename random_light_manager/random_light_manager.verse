# ----------------------------------------------
# 解説記事: https://uecreators.com/random-number-generator-verse/
# ----------------------------------------------

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Random } # ランダム機能(GetRandomInt)を使うために必要です

# ランダムにライトを点灯させるデバイス
random_light_manager := class(creative_device):

    # ライトを配列（リスト）で登録します
    # エディタ上で + を押してライトを何個でも追加できます
    @editable
    MyLights : []customizable_light_device = array{}

    # 起動用のボタン
    @editable
    Button : button_device = button_device{}

    # ゲーム開始時の処理
    OnBegin<override>()<suspends>:void=
        # ボタンが押されたら OnButtonPushed を実行するよう設定
        Button.InteractedWithEvent.Subscribe(OnButtonPushed)

    # ボタンが押された時の処理
    OnButtonPushed(Agent:agent):void=
        
        # 安全装置：ライトが1つも登録されていないとエラーになるのでチェックします
        if (MyLights.Length > 0):
            
            # 1. まず全てのライトを消灯（リセット）します
            # これをしないと、ボタンを押すたびに点灯するライトが増えていってしまいます
            for (Light : MyLights):
                Light.TurnOff()

            # 2. ランダムな数字（インデックス）を決定します
            # 最小値 0, 最大値 (ライトの数 - 1) の間で計算します
            RandomIndex := GetRandomInt(0, MyLights.Length - 1)

            # 3. 決まった数字を使って配列からライトを取り出し、点灯させます
            # 配列へのアクセス(MyLights[...])は失敗する可能性があるので if を使います
            if (SelectedLight := MyLights[RandomIndex]):
                SelectedLight.TurnOn()
                Print("ライト番号 {RandomIndex} を点灯しました")