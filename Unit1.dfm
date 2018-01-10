object frmUdp: TfrmUdp
  Left = 308
  Top = 183
  Width = 592
  Height = 487
  Caption = 'frmUdp'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnStartStop: TButton
    Left = 16
    Top = 8
    Width = 145
    Height = 25
    Caption = 'Start UDP Server'
    TabOrder = 0
    OnClick = btnStartStopClick
  end
  object Panel1: TPanel
    Left = 248
    Top = 8
    Width = 57
    Height = 25
    Caption = 'Panel1'
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 308
    Top = 8
    Width = 57
    Height = 25
    Caption = 'Panel2'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 324
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 3
    OnClick = Button1Click
  end
  object udp: TIdUDPServer
    Bindings = <
      item
        IP = '192.168.0.98'
        Port = 1777
      end>
    DefaultPort = 1777
    OnUDPRead = udpUDPRead
    OnUDPException = udpUDPException
    Left = 192
    Top = 8
  end
end
