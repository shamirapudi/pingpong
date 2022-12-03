unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    lblScore: TLabel;
    lblGameOver: TLabel;
    lblRestart: TLabel;
    Paddle: TShape;
    Ball: TShape;
    tmrGame: TTimer;
    procedure ControlPaddle(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure lblRestartClick(Sender: TObject);
    procedure lblRestartMouseEnter(Sender: TObject);
    procedure lblRestartMouseLeave(Sender: TObject);
    procedure PaddleMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure tmrGameTimer(Sender: TObject);

  private
  procedure InitGame;
  procedure UpdateScore;
  procedure GameOver;
  procedure IncreaseSpeed;
  public

  end;

var
  Form1: TForm1;
  Score: Integer;
  SpeedX,SpeedY: Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ControlPaddle(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Paddle.Left:= x - Paddle.Width div 2;
  Paddle.top:= ClientHeight - Paddle.Height - 2;


end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered:=True;
  InitGame;

end;

procedure TForm1.lblRestartClick(Sender: TObject);
begin
  InitGame;
end;

procedure TForm1.lblRestartMouseEnter(Sender: TObject);
begin
  lblRestart.Font.Style := [fsBold];
end;

procedure TForm1.lblRestartMouseLeave(Sender: TObject);
begin
  lblRestart.Font.Style:= [];
end;

procedure TForm1.PaddleMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ControlPaddle(Sender,Shift,X+Paddle.Left,Y+Paddle.Top);
end;

procedure TForm1.tmrGameTimer(Sender: TObject);
begin
//movements
  Ball.left:= ball.Left + SpeedX;
  Ball.top := Ball.top + SpeedY;
//wall detection
  if Ball.Top  <=  0 then SpeedY:=-SpeedY;
  if (Ball.Left <=  0) or (Ball.Left +  ball.width >= ClientWidth) then SpeedX:=-SpeedX;

  //game over
  if Ball.Top + Ball.Height >= ClientWidth then GameOver ;

  //where ball is valid
  if (Ball.left + ball.width >= paddle.left) and (ball.left <= paddle.left +
  paddle.Width)
//when it bounces off
  and (Ball.Top + Ball.Height >= Paddle.Top) then
  begin
   SpeedY:=-SpeedY;
   IncreaseSpeed;
   Inc(Score);
   UpdateScore;
  end;

end;

procedure TForm1.InitGame;
begin
  Score:=0;
  SpeedX:=4;
  SpeedY:=4;
  lblGameOver.Visible:=False;
  lblRestart.Visible:=False;
  lblRestart.Font.Style:= [];
  Ball.Left:=10;
  Ball.Top:=10;
  UpdateScore;
  tmrGame.Enabled:=true;
end;

procedure TForm1.UpdateScore;
begin
  lblScore.Caption:= 'Score: ' + IntToStr(Score);

end;

procedure TForm1.GameOver;
begin
  { TODO : ceeate gameover screeen }
  tmrGame.Enabled := False;
  lblRestart.Visible:=True;
  lblGameOver.Visible:=True;
end;

procedure TForm1.IncreaseSpeed;
begin
  if SpeedX > 0 then Inc(SpeedX) else Dec(SpeedX);
  if SpeedY > 0 then Inc(SpeedY) else Dec(SpeedY);
end;





end.

