# ----------------------------------------------
# Documentation: https://uecreators.com/camera-controls-verse
# ----------------------------------------------

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

side_scroller_manager := class(creative_device):

    # 1. 横スクロール用のカメラ（固定角度カメラ）
    # エディタで Yaw: -90 などに設定
    @editable
    SideCamera : gameplay_camera_fixed_angle_device = gameplay_camera_fixed_angle_device{}

    # 2. 横スクロール用の操作
    # 「Add to Players on Start」をFalseに
    @editable
    SideControls : gameplay_controls_side_scroller_device = gameplay_controls_side_scroller_device{}

    # 3. 切り替えエリア（ボリューム）
    @editable
    SideScrollZone : volume_device = volume_device{}

    OnBegin<override>()<suspends>:void=
        SideScrollZone.AgentEntersEvent.Subscribe(OnEnterSideScroll)
        SideScrollZone.AgentExitsEvent.Subscribe(OnExitSideScroll)

    # エリアに入ったら「横スクロール」開始
    OnEnterSideScroll(Agent:agent):void=
            SideCamera.AddTo(Agent)
            SideControls.AddTo(Agent)
            Print("モード変更：2D横スクロール")

    # エリアを出たら元に戻す
    OnExitSideScroll(Agent:agent):void=
            SideCamera.RemoveFrom(Agent)
            SideControls.RemoveFrom(Agent)
            Print("モード変更：通常視点")