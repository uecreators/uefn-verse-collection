# ----------------------------------------------
# Documentation: https://uecreators.com/volume-device-verse
# ----------------------------------------------

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 空間センサーを使って照明を制御するデバイス
volume_sensor_manager := class(creative_device):
            
    # エディタで配置したボリューム仕掛けを登録
    @editable
    MyVolume : volume_device = volume_device{}

    # 制御対象のライト（Customizable Light）を登録
    @editable
    MyLight : customizable_light_device = customizable_light_device{}

    # ゲーム開始時の処理
    OnBegin<override>()<suspends>:void=
        # 1. 誰か（Agent）が入った時のイベントを登録（Subscribe）
        MyVolume.AgentEntersEvent.Subscribe(OnAgentEnter)

        # 2. 誰か（Agent）が出た時のイベントを登録
        MyVolume.AgentExitsEvent.Subscribe(OnAgentExit)

    # エリアに入った時に実行される関数
    OnAgentEnter(Agent:agent):void=
        Print("エリアへの侵入を検知。ライトを点灯します。")
        # ライトを点灯させる 
        MyLight.TurnOn()

    # エリアから出た時に実行される関数
    OnAgentExit(Agent:agent):void=
        Print("エリアからの退出を確認。ライトを消灯します。")
        # ライトを消灯させる 
        MyLight.TurnOff()