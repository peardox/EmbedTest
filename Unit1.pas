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
  H5Py, SciPy;

type
  TForm1 = class(TForm)
    PythonEngine1: TPythonEngine;
    PythonGUIInputOutput1: TPythonGUIInputOutput;
    PyEmbeddedResEnvironment391: TPyEmbeddedResEnvironment39;
    Memo1: TMemo;
    SynEdit1: TSynEdit;
    SynPythonSyn1: TSynPythonSyn;
    Splitter1: TSplitter;
    PyTorch1: TPyTorch;
    TorchVision1: TTorchVision;
    NumPy1: TNumPy;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    H5Py1: TH5Py;
    SciPy1: TSciPy;
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
    procedure PyTorch1AfterInstall(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure PythonEngine1AfterLoad(Sender: TObject);
    procedure PythonEngine1AfterInit(Sender: TObject);
    procedure NumPy1BeforeImport(Sender: TObject);
    procedure PyTorch1BeforeImport(Sender: TObject);
    procedure TorchVision1BeforeImport(Sender: TObject);
    procedure TorchVision1AfterInstall(Sender: TObject);
    procedure NumPy1AfterInstall(Sender: TObject);
    procedure H5Py1AfterInstall(Sender: TObject);
    procedure H5Py1BeforeImport(Sender: TObject);
    procedure H5Py1BeforeInstall(Sender: TObject);
    procedure NumPy1BeforeInstall(Sender: TObject);
    procedure TorchVision1BeforeInstall(Sender: TObject);
    procedure PyTorch1BeforeInstall(Sender: TObject);
    procedure SciPy1AfterInstall(Sender: TObject);
    procedure SciPy1BeforeImport(Sender: TObject);
    procedure SciPy1BeforeInstall(Sender: TObject);
  private
    { Private declarations }
//    Packager: TPyPackage;
    FTask: ITask;
    SystemAvailable: Boolean;
    SystemActivated: Boolean;
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

implementation

uses VarPyth;

{$R *.dfm}

function TForm1.IsTaskRunning: boolean;
begin
  if FTask = Nil then
    Result := False
  else
    Result := not (FTask.Status in [TTaskStatus.Completed, TTaskStatus.Exception]);
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

procedure TForm1.NumPy1BeforeImport(Sender: TObject);
begin
  Log('Importing Numpy');
  UpdateInstallationStatus('Importing Numpy', String.Empty);
  MaskFPUExceptions(True);
end;

procedure TForm1.NumPy1BeforeInstall(Sender: TObject);
begin
  MaskFPUExceptions(True);
  Log('Installing NumPy');
  UpdateInstallationStatus('Installing NumPy', String.Empty);
end;

procedure TForm1.PyTorch1BeforeImport(Sender: TObject);
begin
  Log('Importing Torch');
  UpdateInstallationStatus('Importing Torch', String.Empty);
  MaskFPUExceptions(True);
end;

procedure TForm1.PyTorch1BeforeInstall(Sender: TObject);
begin
  MaskFPUExceptions(True);
  Log('Installing Torch');
  UpdateInstallationStatus('Installing Torch', String.Empty);
end;

procedure TForm1.NumPy1AfterInstall(Sender: TObject);
begin
  Log('Numpy Installed');
end;

procedure TForm1.H5Py1AfterInstall(Sender: TObject);
begin
  Log('H5Py Installed');
end;

procedure TForm1.H5Py1BeforeImport(Sender: TObject);
begin
  Log('Importing H5Py');
end;

procedure TForm1.H5Py1BeforeInstall(Sender: TObject);
begin
  MaskFPUExceptions(True);
  Log('Installing H5Py');
  UpdateInstallationStatus('Installing H5Py', String.Empty);
end;

procedure TForm1.PyTorch1AfterInstall(Sender: TObject);
begin
  Log('Torch Installed');
end;

procedure TForm1.TorchVision1AfterInstall(Sender: TObject);
begin
  Log('TorchVision Installed');
end;

procedure TForm1.TorchVision1BeforeImport(Sender: TObject);
begin
  Log('Importing TorchVision');
  UpdateInstallationStatus('Importing TorchVision', String.Empty);
  MaskFPUExceptions(True);
end;

procedure TForm1.TorchVision1BeforeInstall(Sender: TObject);
begin
  MaskFPUExceptions(True);
  Log('Installing TorchVision');
  UpdateInstallationStatus('Installing TorchVision', String.Empty);
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

procedure TForm1.Button1Click(Sender: TObject);
begin
  SynEdit1.Clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  RunCode();
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

procedure TForm1.FormCreate(Sender: TObject);
begin
  SystemAvailable := False;
  SystemActivated := False;
  Memo1.Clear;
  Button1.Enabled := False;
  Button2.Enabled := False;
  CheckBox1.Enabled := False;
  Memo1.Enabled := False;
  SynEdit1.Enabled := False;
  Log('Getting Ready');
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

        H5Py1.Install();
        FTask.CheckCanceled();

        SciPy1.Install();
        FTask.CheckCanceled();

        TThread.Queue(nil, procedure() begin
          Numpy1.Import();
          PyTorch1.Import();
          TorchVision1.Import();
          H5Py1.Import();
          SciPy1.Import();

          Log('Ready');
          UpdateInstallationStatus('Ready', String.Empty);
          SystemAvailable := True;
          Button1.Enabled := True;
          Button2.Enabled := True;
          CheckBox1.Enabled := True;
          Memo1.Enabled := True;
          SynEdit1.Enabled := True;
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

procedure TForm1.SciPy1AfterInstall(Sender: TObject);
begin
  Log('SciPy Installed');
end;

procedure TForm1.SciPy1BeforeImport(Sender: TObject);
begin
  Log('Importing SciPy');
  UpdateInstallationStatus('Importing SciPy', String.Empty);
  MaskFPUExceptions(True);
end;

procedure TForm1.SciPy1BeforeInstall(Sender: TObject);
begin
  MaskFPUExceptions(True);
  Log('Installing SciPy');
  UpdateInstallationStatus('Installing SciPy', String.Empty);
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
