# ----------------------------------------------
# Documentation: https://uecreators.com/camera-controls-verse
# ----------------------------------------------

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# プレイヤーの視点と操作を管理するデバイス
camera_and_input_manager := class(creative_device):

    # --- 仕掛けの登録 ---

    # 1. 切り替えたいカメラ（例：固定角度カメラ）
    @editable
    MyCamera : gameplay_camera_fixed_angle_device = gameplay_camera_fixed_angle_device{}

    # 2. 切り替えたい操作（例：三人称操作）　「Add to Players on Start」をFalseに
    @editable
    MyControls : gameplay_controls_third_person_device = gameplay_controls_third_person_device{}

    # 3. 判定エリア（ボリュームの仕掛け）
    @editable
    MyVolume : volume_device = volume_device{}

    # --- 処理の本体 ---

    # ゲーム開始時に呼ばれる
    OnBegin<override>()<suspends>:void=
        # ボリュームに「入った時」と「出た時」のイベントを登録
        MyVolume.AgentEntersEvent.Subscribe(OnPlayerEnters)
        MyVolume.AgentExitsEvent.Subscribe(OnPlayerExits)

    # ボリュームに入った時の処理
    OnPlayerEnters(Agent:agent):void=
        # カメラと操作をそのプレイヤーに適用
        MyCamera.AddTo(Agent)
        MyControls.AddTo(Agent)
        Print("ボリューム進入：カメラと操作を有効化")

    # ボリュームから出た時の処理
    OnPlayerExits(Agent:agent):void=
        # 適用していたカメラと操作を外す（元の視点に戻る）
        MyCamera.RemoveFrom(Agent)
        MyControls.RemoveFrom(Agent)
        Print("ボリューム脱出：カメラと操作を解除")