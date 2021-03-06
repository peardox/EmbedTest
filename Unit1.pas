unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  System.IOUtils, System.Threading, System.Zip, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PyEnvironment, PyEnvironment.Embeddable,
  PythonEngine, Vcl.PythonGUIInputOutput, Vcl.StdCtrls,
  PyEnvironment.Embeddable.Res, PyEnvironment.Embeddable.Res.Python39,
  SynEditHighlighter, SynEditCodeFolding, SynHighlighterPython, SynEdit,
  PyPackage,
  Vcl.ExtCtrls, PyCommon, PyModule, PyTorch, NumPy, TorchVision, Vcl.ComCtrls,
  SciPy, Vcl.ExtDlgs;

type
  TForm1 = class(TForm)
    PythonEngine1: TPythonEngine;
    PythonGUIInputOutput1: TPythonGUIInputOutput;
    PyEmbeddedResEnvironment391: TPyEmbeddedResEnvironment39;
    Memo1: TMemo;
    SynPythonSyn1: TSynPythonSyn;
    Splitter1: TSplitter;
    PyTorch1: TPyTorch;
    TorchVision1: TTorchVision;
    NumPy1: TNumPy;
    StatusBar1: TStatusBar;
    SciPy1: TSciPy;
    Panel2: TPanel;
    SynEdit1: TSynEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    TabSheet2: TTabSheet;
    StylePanelLeft: TPanel;
    StylePanelRight: TPanel;
    Panel3: TPanel;
    Button4: TButton;
    Panel4: TPanel;
    Button5: TButton;
    Label1: TLabel;
    Label2: TLabel;
    ContentImage: TImage;
    Image2: TImage;
    ImageFileDialog: TOpenPictureDialog;
    StyleDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure PyEmbeddedResEnvironment391BeforeDeactivate(Sender: TObject;
      const APythonVersion: string);
    procedure PyEmbeddedResEnvironment391AfterDeactivate(Sender: TObject;
      const APythonVersion: string);
    procedure PyEmbeddedResEnvironment391AfterSetup(Sender: TObject;
      const APythonVersion: string);
    procedure PyEmbeddedResEnvironment391BeforeActivate(Sender: TObject;
      const APythonVersion: string);
    procedure PyEmbeddedResEnvironment391BeforeSetup(Sender: TObject;
      const APythonVersion: string);
    procedure PyEmbeddedResEnvironment391Ready(Sender: TObject;
      const APythonVersion: string);
    procedure PyEmbeddedResEnvironment391ZipProgress(Sender: TObject;
      ADistribution: TPyCustomEmbeddableDistribution; FileName: string;
      Header: TZipHeader; Position: Int64);
    procedure SynEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure PythonEngine1AfterLoad(Sender: TObject);
    procedure PythonEngine1AfterInit(Sender: TObject);

    procedure PackageConfigureInstall(Sender: TObject);
    procedure PackageAfterInstall(Sender: TObject);
    procedure PackageInstallError(Sender: TObject; AErrorMessage: string);
    procedure PackageBeforeImport(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure PythonGUIInputOutput1SendUniData(Sender: TObject;
      const Data: string);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure StylePanelLeftResize(Sender: TObject);
  private
    { Private declarations }
//    Packager: TPyPackage;
    FTask: ITask;
    SystemAvailable: Boolean;
    SystemActivated: Boolean;
    procedure EnableForm(Enable: Boolean);
    procedure CreateSystem;
    procedure UpdateInstallationStatus(const AStatus,
      ADescription: string);
    procedure Log(AMsg: String);
    function IsTaskRunning(): boolean;
    procedure RunCode();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

function ClampToByte(Value: LongInt): LongInt; inline;
procedure RGBToYUV(R, G, B: Byte; var Y, U, V: Byte);
procedure YUVToRGB(Y, U, V: Byte; var R, G, B: Byte);

implementation

uses VarPyth, JPeg;

{$R *.dfm}

function ClampToByte(Value: LongInt): LongInt;
begin
  Result := Value;
  if Result > 255 then
    Result := 255
  else if Result < 0 then
    Result := 0;
end;

procedure RGBToYUV(R, G, B: Byte; var Y, U, V: Byte);
begin
  Y := ClampToByte(Round( 0.257 * R + 0.504 * G + 0.098 * B) + 16);
  V := ClampToByte(Round( 0.439 * R - 0.368 * G - 0.071 * B) + 128);
  U := ClampToByte(Round(-0.148 * R - 0.291 * G + 0.439 * B) + 128);
end;

procedure YUVToRGB(Y, U, V: Byte; var R, G, B: Byte);
var
  CY, CU, CV: LongInt;
begin
  CY := Y - 16;
  CU := U - 128;
  CV := V - 128;
  R := ClampToByte(Round(1.164 * CY - 0.002 * CU + 1.596 * CV));
  G := ClampToByte(Round(1.164 * CY - 0.391 * CU - 0.813 * CV));
  B := ClampToByte(Round(1.164 * CY + 2.018 * CU - 0.001 * CV));
end;


function TForm1.IsTaskRunning: boolean;
begin
  if FTask = Nil then
    Result := False
  else
    Result := not (FTask.Status in [TTaskStatus.Completed, TTaskStatus.Exception]);
end;

procedure TForm1.UpdateInstallationStatus(const AStatus,
  ADescription: string);
begin
  if TThread.CurrentThread.ThreadID <> MainThreadID then
    TThread.Synchronize(nil, procedure() begin
      StatusBar1.Panels[0].Text := AStatus;
      StatusBar1.Panels[1].Text := ADescription;
      StatusBar1.Repaint;
    end)
  else
    begin
      StatusBar1.Panels[0].Text := AStatus;
      StatusBar1.Panels[1].Text := ADescription;
      StatusBar1.Repaint;
    end;
end;

procedure TForm1.Log(AMsg: String);
begin
  if TThread.CurrentThread.ThreadID <> MainThreadID then
    TThread.Synchronize(nil, procedure() begin
     Memo1.Lines.Add(AMsg);
     Memo1.Repaint;
    end)
  else
   Memo1.Lines.Add(AMsg);
end;

procedure TForm1.PackageConfigureInstall(Sender: TObject);
begin
  TPyManagedPackage(Sender).AfterInstall := PackageAfterInstall;
  TPyManagedPackage(Sender).OnInstallError := PackageInstallError;
  TPyManagedPackage(Sender).BeforeImport := PackageBeforeImport;

  MaskFPUExceptions(True);
  Log('Installing ' + TPyPackage(Sender).PyModuleName);
  UpdateInstallationStatus('Installing ' + TPyPackage(Sender).PyModuleName, String.Empty);
end;

procedure TForm1.PackageAfterInstall(Sender: TObject);
begin
  Log(TPyPackage(Sender).PyModuleName + ' Installed');
end;

procedure TForm1.PackageBeforeImport(Sender: TObject);
begin
  Log('Importing ' + TPyPackage(Sender).PyModuleName);
  UpdateInstallationStatus('Importing ' + TPyPackage(Sender).PyModuleName, String.Empty);
  MaskFPUExceptions(True);
end;

procedure TForm1.PackageInstallError(Sender: TObject; AErrorMessage: string);
begin
  Log(TPyPackage(Sender).PyModuleName + ' : ' + AErrorMessage);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SynEdit1.Clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  RunCode();
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  SynEdit1.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'testcode.py');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if ImageFileDialog.Execute then
  begin
    ContentImage.Picture.LoadFromFile(ImageFileDialog.FileName);
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if StyleDialog.Execute then
  begin

  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if CheckBox1.Checked then
    begin
      if SystemActivated then
        PyEmbeddedResEnvironment391.Deactivate;
      TDirectory.Delete(PyEmbeddedResEnvironment391.EnvironmentPath, True);
    end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if IsTaskRunning() then begin
    ShowMessage('Waiting for operations...');
    FTask.Cancel();
    while IsTaskRunning() do begin
      FTask.Wait(100);
      //Avoid synchronization deadlock
      Application.ProcessMessages();
    end;
  end;
end;

procedure TForm1.EnableForm(Enable: Boolean);
begin
  Button1.Enabled := Enable;
  Button2.Enabled := Enable;
  Button3.Enabled := Enable;
  CheckBox1.Enabled := Enable;
  Memo1.Enabled := Enable;
  SynEdit1.Enabled := Enable;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SystemAvailable := False;
  SystemActivated := False;
  Memo1.Clear;
  EnableForm(False);
  Log('Getting Ready');
  SynEdit1.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'testcode.py');
  CreateSystem;
end;

procedure TForm1.CreateSystem;
begin
  if not SystemAvailable then
    begin
      MaskFPUExceptions(True);
      FTask := TTask.Run(procedure() begin
        PyEmbeddedResEnvironment391.Setup(PyEmbeddedResEnvironment391.PythonVersion);
        FTask.CheckCanceled();
        TThread.Synchronize(nil, procedure() begin
          PyEmbeddedResEnvironment391.Activate(PyEmbeddedResEnvironment391.PythonVersion);
        end);
        FTask.CheckCanceled();

        Numpy1.Install();
        FTask.CheckCanceled();

        PyTorch1.Install();
        FTask.CheckCanceled();

        TorchVision1.Install();
        FTask.CheckCanceled();

        SciPy1.Install();
        FTask.CheckCanceled();

        TThread.Queue(nil, procedure() begin
{
          Numpy1.Import();
          PyTorch1.Import();
          TorchVision1.Import();
          SciPy1.Import();
}
          Log('Ready');
          UpdateInstallationStatus('Ready', String.Empty);
          SystemAvailable := True;
          EnableForm(True);
        end);
      end);
    end;
end;

procedure TForm1.PyEmbeddedResEnvironment391AfterDeactivate(Sender: TObject;
  const APythonVersion: string);
begin
  Log('FormCreate');
end;

procedure TForm1.PyEmbeddedResEnvironment391AfterSetup(Sender: TObject;
  const APythonVersion: string);
begin
  Log('PyEmbeddedResEnvironment391AfterSetup');
end;

procedure TForm1.PyEmbeddedResEnvironment391BeforeActivate(Sender: TObject;
  const APythonVersion: string);
begin
  Log('BeforeActivate');
end;

procedure TForm1.PyEmbeddedResEnvironment391BeforeDeactivate(Sender: TObject;
  const APythonVersion: string);
begin
  Log('BeforeDeactivate');
end;

procedure TForm1.PyEmbeddedResEnvironment391BeforeSetup(Sender: TObject;
  const APythonVersion: string);
begin
  Log('BeforeSetup');
end;

procedure TForm1.PyEmbeddedResEnvironment391Ready(Sender: TObject;
  const APythonVersion: string);
begin
  Log('Ready');
end;


procedure TForm1.PyEmbeddedResEnvironment391ZipProgress(Sender: TObject;
  ADistribution: TPyCustomEmbeddableDistribution; FileName: string;
  Header: TZipHeader; Position: Int64);
begin
  UpdateInstallationStatus(Filename, IntToStr(Position));
end;

procedure TForm1.PythonEngine1AfterInit(Sender: TObject);
begin
  Log('Python Initialised');
  SystemActivated := True;
end;

procedure TForm1.PythonEngine1AfterLoad(Sender: TObject);
begin
  Log('Python Loaded');
end;

procedure TForm1.PythonGUIInputOutput1SendUniData(Sender: TObject;
  const Data: string);
begin
  Log(Data);
  Application.ProcessMessages;
end;

procedure TForm1.StylePanelLeftResize(Sender: TObject);
begin
  StylePanelLeft.Width := TabSheet2.Width div 2;
//  StylePanelLeft.Height := TabSheet2.Height;
//  Log('Panel = ' + IntToStr(StylePanelLeft.Width) + 'x' + IntToStr(StylePanelLeft.Height));
end;

procedure TForm1.SynEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
end;

procedure TForm1.RunCode();
begin
  if SystemAvailable then
    begin
      Memo1.Clear;
      try
        MaskFPUExceptions(True);
        try
          PythonEngine1.ExecStrings(SynEdit1.Lines);
        except
          on E: EPyIndentationError do
            begin
              Log('Indentation Exception : Line = ' + IntToStr(E.ELineNumber) +
                  ', Offset = ' + IntToStr(E.EOffset));
            end;
          on E: EPyImportError do
            begin
              Log('Import Exception : ' + E.EValue + ' : ' + E.EName);
            end;
          on E: Exception do
            begin
              Log('Unhandled Exception');
              Log('Class : ' + E.ClassName);
              Log('Error : ' + E.Message);
            end;
        end;
      finally
          MaskFPUExceptions(False);
      end;
    end;
end;

end.
