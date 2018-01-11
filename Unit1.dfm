object frmUdp: TfrmUdp
  Left = 342
  Top = 166
  Width = 700
  Height = 645
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
  object Label1: TLabel
    Left = 32
    Top = 80
    Width = 18
    Height = 13
    Caption = 'acc'
  end
  object Label2: TLabel
    Left = 32
    Top = 124
    Width = 15
    Height = 13
    Caption = 'gra'
  end
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
  object pnlAcc: TPanel
    Left = 104
    Top = 64
    Width = 181
    Height = 41
    Caption = 'pnlAcc'
    TabOrder = 3
  end
  object pnlGra: TPanel
    Left = 104
    Top = 108
    Width = 181
    Height = 41
    TabOrder = 4
  end
  object pnlMaxAcc: TPanel
    Left = 288
    Top = 64
    Width = 49
    Height = 41
    TabOrder = 5
  end
  object pnlMinAcc: TPanel
    Left = 52
    Top = 64
    Width = 49
    Height = 41
    TabOrder = 6
  end
  object Panel3: TPanel
    Left = 408
    Top = 16
    Width = 61
    Height = 41
    Caption = 'Panel3'
    TabOrder = 7
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
