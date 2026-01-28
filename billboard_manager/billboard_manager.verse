# ----------------------------------------------
# Documentation: https://uecreators.com/billboard-verse
# ----------------------------------------------

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# ボタンで看板の文字を書き換えるデバイス
billboard_manager := class(creative_device):

    # 1. 書き換えたい看板（billboard）
    @editable
    Mybillboard : billboard_device = billboard_device{}

    # 2. 切り替えスイッチ
    @editable
    MySwitch : switch_device = switch_device{}

    # ローカライズ（翻訳）用テキストの定義
    # Verseでbillboardの文字を変えるには、"message"という型にする必要があります
    TextOpen<localizes> : message = "STATUS: OPEN"
    TextClosed<localizes> : message = "STATUS: CLOSED"

    # ゲーム開始時の処理
    OnBegin<override>()<suspends>:void=
        # スイッチの状態が変わったらイベント発動
        MySwitch.TurnedOnEvent.Subscribe(OnOpened)
        MySwitch.TurnedOffEvent.Subscribe(OnClosed)

    # スイッチON：billboardを「OPEN」にする
    OnOpened(Agent:agent):void=
        # SetText関数には、stringではなくmessage型（TextOpen）を渡します
        Mybillboard.SetText(TextOpen)
        Print("billboardを「OPEN」に変更しました")

    # スイッチOFF：billboardを「CLOSED」にする
    OnClosed(Agent:agent):void=
        Mybillboard.SetText(TextClosed)
        Print("billboardを「CLOSED」に変更しました")