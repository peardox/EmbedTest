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
  object SynEdit1: TSynEdit
    Left = 0
    Top = 273
    Width = 635
    Height = 263
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
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Consolas'
    Gutter.Font.Style = []
    Highlighter = SynPythonSyn1
    Lines.Strings = (
      'import numpy'
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
  object Panel1: TPanel
    Left = 0
    Top = 536
    Width = 635
    Height = 23
    Align = alBottom
    TabOrder = 3
    object CheckBox1: TCheckBox
      Left = 512
      Top = 1
      Width = 122
      Height = 21
      Align = alRight
      Caption = 'Wipe Python on Exit'
      TabOrder = 0
      Visible = False
    end
    object Button1: TButton
      Left = 87
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
    BeforeImport = PyTorch1BeforeImport
    PythonEngine = PythonEngine1
    PyEnvironment = PyEmbeddedResEnvironment391
    ManagerKind = pip
    Managers.Pip.InstallOptions.ExtraIndexUrl = 'https://download.pytorch.org/whl/cu113'
    AutoInstall = False
    BeforeInstall = PyTorch1BeforeInstall
    OnInstallError = PackageInstallError
    AfterInstall = PyTorch1AfterInstall
    Left = 520
    Top = 192
  end
  object TorchVision1: TTorchVision
    AutoImport = False
    BeforeImport = TorchVision1BeforeImport
    PythonEngine = PythonEngine1
    PyEnvironment = PyEmbeddedResEnvironment391
    ManagerKind = pip
    Managers.Pip.InstallOptions.ExtraIndexUrl = 'https://download.pytorch.org/whl/cu113'
    AutoInstall = False
    BeforeInstall = TorchVision1BeforeInstall
    AfterInstall = TorchVision1AfterInstall
    Left = 448
    Top = 192
  end
  object NumPy1: TNumPy
    AutoImport = False
    BeforeImport = NumPy1BeforeImport
    PythonEngine = PythonEngine1
    PyEnvironment = PyEmbeddedResEnvironment391
    ManagerKind = pip
    AutoInstall = False
    BeforeInstall = NumPy1BeforeInstall
    AfterInstall = NumPy1AfterInstall
    Left = 376
    Top = 192
  end
  object H5Py1: TH5Py
    AutoImport = False
    BeforeImport = H5Py1BeforeImport
    PythonEngine = PythonEngine1
    PyEnvironment = PyEmbeddedResEnvironment391
    ManagerKind = pip
    AutoInstall = False
    BeforeInstall = H5Py1BeforeInstall
    AfterInstall = H5Py1AfterInstall
    Left = 312
    Top = 192
  end
  object SciPy1: TSciPy
    AutoImport = False
    BeforeImport = SciPy1BeforeImport
    PythonEngine = PythonEngine1
    PyEnvironment = PyEmbeddedResEnvironment391
    ManagerKind = pip
    AutoInstall = False
    BeforeInstall = SciPy1BeforeInstall
    AfterInstall = SciPy1AfterInstall
    Left = 248
    Top = 192
  end
end
