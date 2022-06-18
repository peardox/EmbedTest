object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 578
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 270
    Width = 635
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 297
    ExplicitWidth = 281
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 635
    Height = 270
    TabStop = False
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 559
    Width = 635
    Height = 19
    Panels = <
      item
        Text = 'Hello'
        Width = 500
      end
      item
        Alignment = taRightJustify
        Text = 'World'
        Width = 400
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 273
    Width = 635
    Height = 286
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 2
    ExplicitLeft = 8
    ExplicitTop = 288
    ExplicitWidth = 185
    ExplicitHeight = 41
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 635
      Height = 286
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Code'
        object Panel1: TPanel
          Left = 0
          Top = 235
          Width = 627
          Height = 23
          Align = alBottom
          TabOrder = 0
          ExplicitTop = 263
          ExplicitWidth = 635
          object CheckBox1: TCheckBox
            Left = 504
            Top = 1
            Width = 122
            Height = 21
            Align = alRight
            Caption = 'Wipe Python on Exit'
            TabOrder = 0
            Visible = False
            ExplicitLeft = 512
          end
          object Button1: TButton
            Left = 82
            Top = 1
            Width = 75
            Height = 21
            Align = alCustom
            Caption = 'Clear Editor'
            TabOrder = 1
            OnClick = Button1Click
          end
          object Button2: TButton
            Left = 1
            Top = 1
            Width = 75
            Height = 21
            Align = alLeft
            Caption = 'Run Code'
            TabOrder = 2
            OnClick = Button2Click
          end
          object Button3: TButton
            Left = 163
            Top = 1
            Width = 75
            Height = 21
            Align = alCustom
            Caption = 'ReLoad Code'
            TabOrder = 3
            TabStop = False
            OnClick = Button3Click
          end
        end
        object SynEdit1: TSynEdit
          Left = 0
          Top = 0
          Width = 627
          Height = 235
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Font.Quality = fqClearTypeNatural
          TabOrder = 1
          OnKeyPress = SynEdit1KeyPress
          UseCodeFolding = False
          Gutter.AutoSize = True
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -11
          Gutter.Font.Name = 'Consolas'
          Gutter.Font.Style = []
          Gutter.RightOffset = 15
          Gutter.ShowLineNumbers = True
          Highlighter = SynPythonSyn1
          Lines.Strings = (
            'import torch'
            ''
            'gpu_supported = 0'
            'try:'
            '    torch.cuda.init()'
            '    if(torch.cuda.is_available()):'
            '        gpu_supported = 1'
            '        print("CUDA Available : ",torch.cuda.is_available())'
            '        print("CUDA Devices : ",torch.cuda.device_count())'
            '        print("CUDA Arch List : ",torch.cuda.get_arch_list())'
            '        for x in range(torch.cuda.device_count()):'
            
              '            print("CUDA Capabilities : ",torch.cuda.get_device_c' +
              'apability(x))'
            
              '            print("CUDA Device Name : ",torch.cuda.get_device_na' +
              'me(x))'
            
              '            print("CUDA Device Memory : ",torch.cuda.mem_get_inf' +
              'o(x))'
            
              '            print("CUDA Device Properties : ",torch.cuda.get_dev' +
              'ice_properties(x))'
            '            print(torch.cuda.memory_summary(x))'
            'except:'
            '    print("No supported GPUs detected")'
            ''
            ''
            'print("GPU Support : ", gpu_supported);'
            '')
          TabWidth = 4
          WantTabs = True
          ExplicitWidth = 635
          ExplicitHeight = 286
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Style'
        ImageIndex = 1
      end
    end
  end
  object PythonEngine1: TPythonEngine
    AutoLoad = False
    OnAfterLoad = PythonEngine1AfterLoad
    IO = PythonGUIInputOutput1
    OnAfterInit = PythonEngine1AfterInit
    Left = 520
    Top = 24
  end
  object PythonGUIInputOutput1: TPythonGUIInputOutput
    OnSendUniData = PythonGUIInputOutput1SendUniData
    UnicodeIO = True
    RawOutput = False
    Output = Memo1
    Left = 520
    Top = 80
  end
  object PyEmbeddedResEnvironment391: TPyEmbeddedResEnvironment39
    BeforeSetup = PyEmbeddedResEnvironment391BeforeSetup
    AfterSetup = PyEmbeddedResEnvironment391AfterSetup
    BeforeActivate = PyEmbeddedResEnvironment391BeforeActivate
    BeforeDeactivate = PyEmbeddedResEnvironment391BeforeDeactivate
    AfterDeactivate = PyEmbeddedResEnvironment391AfterDeactivate
    OnReady = PyEmbeddedResEnvironment391Ready
    AutoLoad = False
    PythonVersion = '3.9'
    PythonEngine = PythonEngine1
    OnZipProgress = PyEmbeddedResEnvironment391ZipProgress
    EnvironmentPath = 'python'
    Left = 520
    Top = 136
  end
  object SynPythonSyn1: TSynPythonSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 528
    Top = 320
  end
  object PyTorch1: TPyTorch
    AutoImport = False
    PythonEngine = PythonEngine1
    PyEnvironment = PyEmbeddedResEnvironment391
    ManagerKind = pip
    Managers.Pip.InstallOptions.ExtraIndexUrl = 'https://download.pytorch.org/whl/cu113'
    AutoInstall = False
    BeforeInstall = PackageConfigureInstall
    Left = 520
    Top = 192
  end
  object TorchVision1: TTorchVision
    AutoImport = False
    PythonEngine = PythonEngine1
    PyEnvironment = PyEmbeddedResEnvironment391
    ManagerKind = pip
    Managers.Pip.InstallOptions.ExtraIndexUrl = 'https://download.pytorch.org/whl/cu113'
    AutoInstall = False
    BeforeInstall = PackageConfigureInstall
    Left = 448
    Top = 192
  end
  object NumPy1: TNumPy
    AutoImport = False
    PythonEngine = PythonEngine1
    PyEnvironment = PyEmbeddedResEnvironment391
    ManagerKind = pip
    AutoInstall = False
    BeforeInstall = PackageConfigureInstall
    Left = 376
    Top = 192
  end
  object SciPy1: TSciPy
    AutoImport = False
    PythonEngine = PythonEngine1
    PyEnvironment = PyEmbeddedResEnvironment391
    ManagerKind = pip
    AutoInstall = False
    BeforeInstall = PackageConfigureInstall
    Left = 312
    Top = 192
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Filter = '*.py'
    Left = 360
    Top = 40
  end
end
