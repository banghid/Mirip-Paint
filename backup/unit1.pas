unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  Buttons, StdCtrls, Arrow, Spin, Types, LCLIntf,LCLType,LCLProc;

type element = record
  x,y:integer;
end;
  objek = record
    titik:array of element;
    area:TRect;
    color:TColor;
    jml_titik:integer;
    ketebalah_garis : Integer;
    color_outline : TColor ;
    obj_type:String;
    style:TPenStyle;
  end;


  { TForm1 }

  TForm1 = class(TForm)
    Arrow1: TArrow;
    Arrow2: TArrow;
    Arrow3: TArrow;
    Arrow4: TArrow;
    BitBtn1: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn16: TBitBtn;
    BitBtn2: TBitBtn;
    btnBucket: TBitBtn;
    btnZoomOut: TBitBtn;
    btnZoomIn: TBitBtn;
    Label9: TLabel;
    Panel4: TPanel;
    ShearingY: TBitBtn;
    ShearingX: TBitBtn;
    Label8: TLabel;
    Panel2: TPanel;
    PencerminanXY: TBitBtn;
    PencerminanX: TBitBtn;
    PencerminanY: TBitBtn;
    btnSelect: TBitBtn;
    btnPensil: TBitBtn;
    BitBtn11: TBitBtn;
    btnPersegi: TBitBtn;
    btnLingkaran: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    ColorButton1: TColorButton;
    ColorButton2: TColorButton;
    ComboBox1: TComboBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    PageControl2: TPageControl;
    Panel1: TPanel;
    Panel11: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinShearing: TSpinEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText5: TStaticText;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure Arrow1Click(Sender: TObject);
    procedure Arrow2Click(Sender: TObject);
    procedure Arrow3Click(Sender: TObject);
    procedure Arrow4Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnPensilClick(Sender: TObject);
    procedure btnPersegiClick(Sender: TObject);
    procedure btnZoomInClick(Sender: TObject);
    procedure btnBucketClick(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure btnLingkaranClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnZoomOutClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure PencerminanXClick(Sender: TObject);
    procedure PencerminanXYClick(Sender: TObject);
    procedure PencerminanYClick(Sender: TObject);
    procedure ShearingXClick(Sender: TObject);
    procedure ShearingYClick(Sender: TObject);
    procedure TabSheet3ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Tampil();
    procedure TitikTengah(x:integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BoundaryFill(x, y, boundary, fill: Integer);
    procedure SelectObjek(x , y:integer);
  private

  public

  end;

var
  Form1: TForm1;
  obj:array of objek;
  //appeare:array of integer;
  selected_obj:integer;
  a,b,i,j,last_obj,x1,y1,x2,y2:integer;
  selected_btn:String;
  mousedownon:Boolean;
  obj_temp:array of objek;
  penstyle:TPenStyle;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormActivate(Sender: TObject);
begin
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  last_obj:=0;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  if last_obj > 1 then
  begin
     for i:= 0 to last_obj do
     begin
          Image1.Canvas.MoveTo(obj[i].titik[obj[i].jml_titik].x,obj[i].titik[obj[i].jml_titik].y);
          for j:= 0 to obj[i].jml_titik do
          begin
               Image1.Canvas.LineTo(obj[i].titik[j].x,obj[i].titik[j].y);
          end;
     end;
     Image1.Refresh;
  end;

end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;


procedure TForm1.PencerminanXClick(Sender: TObject);
begin
  selected_btn:='pencerminan X';
  SetLength(obj,(2*last_obj));
  for i:=last_obj to ((2*last_obj)-1) do
  begin
       SetLength(obj[i].titik,(obj[(i-last_obj)].jml_titik+1));
       obj[i].jml_titik:=obj[(i-last_obj)].jml_titik;
       for j:=0 to obj[i-last_obj].jml_titik do
       begin
            obj[i].titik[j].x:=obj[(i-last_obj)].titik[j].x;
            obj[i].titik[j].y:=Image1.Height - obj[(i-last_obj)].titik[j].y;
       end;
       obj[i].obj_type:=obj[i-last_obj].obj_type;
       obj[i].color:=obj[i-last_obj].color;
       if obj[i].obj_type='persegi' then
       begin
          obj[i].area.Create(obj[i].titik[2].x,obj[i].titik[2].y,obj[i].titik[0].x,obj[i].titik[0].y);
       end;
       if obj[i].obj_type='lingkaran' then
       begin
          obj[i].area.Create(obj[i].titik[1].x,obj[i].titik[1].y,obj[i].titik[0].x,obj[i].titik[0].y);
       end;
       StaticText1.Caption:=selected_btn;
  end;
  last_obj:=(2*last_obj);
  StaticText5.Caption:=IntToStr(last_obj);
  Tampil();
end;

procedure TForm1.PencerminanXYClick(Sender: TObject);
begin
  selected_btn:='pencerminan XY';
  SetLength(obj,(2*last_obj));
  for i:=last_obj to ((2*last_obj)-1) do
  begin
       SetLength(obj[i].titik,(obj[(i-last_obj)].jml_titik+1));
       obj[i].jml_titik:=obj[(i-last_obj)].jml_titik;
       for j:=0 to obj[i-last_obj].jml_titik do
       begin
            obj[i].titik[j].x:=Image1.Width - obj[(i-last_obj)].titik[j].x;
            obj[i].titik[j].y:=Image1.Height - obj[(i-last_obj)].titik[j].y;
       end;
       obj[i].obj_type:=obj[i-last_obj].obj_type;
       obj[i].color:=obj[i-last_obj].color;
       if obj[i].obj_type='persegi' then
       begin
          obj[i].area.Create(obj[i].titik[2].x,obj[i].titik[2].y,obj[i].titik[0].x,obj[i].titik[0].y);
       end;
       if obj[i].obj_type='lingkaran' then
       begin
          obj[i].area.Create(obj[i].titik[1].x,obj[i].titik[1].y,obj[i].titik[0].x,obj[i].titik[0].y);
       end;
       StaticText1.Caption:=selected_btn;
  end;
  last_obj:=(2*last_obj);
  StaticText5.Caption:=IntToStr(last_obj);
  Tampil();
end;

procedure TForm1.PencerminanYClick(Sender: TObject);
begin
  selected_btn:='pencerminan Y';
  SetLength(obj,(2*last_obj));
  for i:=last_obj to ((2*last_obj)-1) do
  begin
       SetLength(obj[i].titik,(obj[(i-last_obj)].jml_titik+1));
       obj[i].jml_titik:=obj[(i-last_obj)].jml_titik;
       for j:=0 to obj[i-last_obj].jml_titik do
       begin
            obj[i].titik[j].x:=Image1.Width - obj[(i-last_obj)].titik[j].x;
            obj[i].titik[j].y:=obj[(i-last_obj)].titik[j].y;
       end;
       obj[i].obj_type:=obj[i-last_obj].obj_type;
       obj[i].color:=obj[i-last_obj].color;
       if obj[i].obj_type='persegi' then
       begin
          obj[i].area.Create(obj[i].titik[2].x,obj[i].titik[2].y,obj[i].titik[0].x,obj[i].titik[0].y);
       end;
       if obj[i].obj_type='lingkaran' then
       begin
          obj[i].area.Create(obj[i].titik[1].x,obj[i].titik[1].y,obj[i].titik[0].x,obj[i].titik[0].y);
       end;
       StaticText1.Caption:=selected_btn;
  end;
  last_obj:=(2*last_obj);
  StaticText5.Caption:=IntToStr(last_obj);
  Tampil();
end;

procedure TForm1.ShearingXClick(Sender: TObject);
begin
  if obj[selected_obj].obj_type='persegi' then
  begin
    obj[selected_obj].titik[0].x := obj[selected_obj].titik[0].x + SpinShearing.Value;
     obj[selected_obj].titik[1].x := obj[selected_obj].titik[1].x + SpinShearing.Value;
     obj[selected_obj].titik[2].x := obj[selected_obj].titik[2].x - SpinShearing.Value;
     obj[selected_obj].titik[3].x := obj[selected_obj].titik[3].x - SpinShearing.Value;
     obj[selected_obj].area.Create(obj[selected_obj].titik[0].x,obj[selected_obj].titik[0].y,obj[selected_obj].titik[2].x,obj[selected_obj].titik[2].y);
  end;
  Tampil();
end;

procedure TForm1.ShearingYClick(Sender: TObject);
begin
  if obj[selected_obj].obj_type='persegi' then
  begin
     obj[selected_obj].titik[0].y := obj[selected_obj].titik[0].y + SpinShearing.Value;
     obj[selected_obj].titik[1].y := obj[selected_obj].titik[1].y - SpinShearing.Value;
     obj[selected_obj].titik[2].y := obj[selected_obj].titik[2].y - SpinShearing.Value;
     obj[selected_obj].titik[3].y := obj[selected_obj].titik[3].y + SpinShearing.Value;
     obj[selected_obj].area.Create(obj[selected_obj].titik[0].x,obj[selected_obj].titik[0].y,obj[selected_obj].titik[2].x,obj[selected_obj].titik[2].y);
  end;
  Tampil();
end;

procedure TForm1.TabSheet3ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;




procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  x1:=X;
  y1:=Y;
  if selected_btn = 'bucket' then
   begin
     BoundaryFill(X,Y,Image1.Canvas.Pen.Color,ColorButton2.ButtonColor);
     SelectObjek(X,Y);
     obj[selected_obj].color:=ColorButton2.ButtonColor;
   end
  else if selected_btn = 'select' then
   begin
     SelectObjek(X,Y);
   end
  else if selected_btn = 'pensil' then
  begin
      Image1.Canvas.MoveTo(X,Y);
  end
  else if selected_btn = 'eraser' then
  begin
    Image1.Canvas.Pen.Color:=clWhite;
    Image1.Canvas.Pen.Width:=SpinEdit3.Value;
    Image1.Canvas.MoveTo(X,Y);
  end
  else if selected_btn <> '' then
  begin
      last_obj:=last_obj+1;
      SetLength(obj,last_obj);
  end;

  mousedownon:= true;

end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  //if mousedownon = true then
  //begin
      //x2:=X;
      //y2:=Y;
      //if selected_btn = 'persegi' then
      //begin
      //     SetLength(obj[last_obj-1].titik,4);
      //     obj[last_obj-1].titik[0].x:=x1; obj[last_obj-1].titik[0].y:=y1;
      //     obj[last_obj-1].titik[1].x:=x2; obj[last_obj-1].titik[1].y:=y1;
      //     obj[last_obj-1].titik[2].x:=x2; obj[last_obj-1].titik[2].x:=y2;
      //     obj[last_obj-1].titik[3].x:=x1; obj[last_obj-1].titik[3].x:=y2;
      //     obj[last_obj-1].jml_titik:=3;
      //     Tampil();
      //end;
  //end;

      if mousedownon = true then
       begin
             if selected_btn = 'pensil' then
             begin
                  Image1.Canvas.LineTo(X,Y);
             end
             else if selected_btn = 'eraser' then
             begin
                  Image1.Canvas.LineTo(X,Y);
             end;

       end;


end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      x2:=X;
      y2:=Y;
      if selected_btn = 'persegi' then
      begin
           SetLength(obj[last_obj-1].titik,4);
           obj[last_obj-1].titik[0].x:=x1; obj[last_obj-1].titik[0].y:=y1;
           obj[last_obj-1].titik[1].x:=x2; obj[last_obj-1].titik[1].y:=y1;
           obj[last_obj-1].titik[2].x:=x2; obj[last_obj-1].titik[2].y:=y2;
           obj[last_obj-1].titik[3].x:=x1; obj[last_obj-1].titik[3].y:=y2;
           obj[last_obj-1].jml_titik:=3;
           obj[last_obj-1].obj_type:='persegi';
           obj[last_obj-1].color:=clWhite;
           obj[last_obj-1].area.Create(x1,y1,x2,y2);
           obj[last_obj-1].style:=penstyle;         
           obj[last_obj-1].ketebalah_garis:=SpinEdit3.Value;
           obj[last_obj-1].color_outline:=ColorButton1.ButtonColor;
           Tampil();
           selected_obj:=last_obj-1;

      end;
      if selected_btn = 'lingkaran' then
      begin
         SetLength(obj[last_obj-1].titik,2);
         obj[last_obj-1].titik[0].x:=x1; obj[last_obj-1].titik[0].y:=y1;
         obj[last_obj-1].titik[1].x:=x2; obj[last_obj-1].titik[1].y:=y2;
         obj[last_obj-1].jml_titik:=1;
         obj[last_obj-1].obj_type:='lingkaran';
         obj[last_obj-1].color:=clWhite;
         obj[last_obj-1].area.Create(x1,y1,x2,y2);
         obj[last_obj-1].style:=penstyle;         
           obj[last_obj-1].ketebalah_garis:=SpinEdit3.Value;
           obj[last_obj-1].color_outline:=ColorButton1.ButtonColor;
         Tampil();
         selected_obj:=last_obj-1;
      end;
      if  selected_btn = 'segitiga' then
      begin 
         SetLength(obj[last_obj-1].titik,3);
         obj[last_obj-1].titik[0].x:=x1; obj[last_obj-1].titik[0].y:=y1;
         obj[last_obj-1].titik[1].x:=x1 - (x2-x1); obj[last_obj-1].titik[1].y:=y2;
         obj[last_obj-1].titik[2].x:=x2; obj[last_obj-1].titik[2].y:=y2;
         obj[last_obj-1].jml_titik:=2;
         obj[last_obj-1].obj_type:='segitiga';
         obj[last_obj-1].color:=clWhite;
         obj[last_obj-1].area.Create((x1- (x2-x1)),y1,x2,y2);
         obj[last_obj-1].style:=penstyle;    
           obj[last_obj-1].ketebalah_garis:=SpinEdit3.Value;
           obj[last_obj-1].color_outline:=ColorButton1.ButtonColor;
         Tampil();
         selected_obj:=last_obj-1;
      end;
      if selected_btn = 'pensil' then
      begin
      end;
      if selected_btn = 'segilima' then
      begin
         SetLength(obj[last_obj-1].titik,5);
           obj[last_obj-1].titik[0].x:=x1;                           obj[last_obj-1].titik[0].y:=y1;
           obj[last_obj-1].titik[1].x:=(((x2+25-x1) div 2)+x1);      obj[last_obj-1].titik[1].y:=y1-40;
           obj[last_obj-1].titik[2].x:=x2+25;                       obj[last_obj-1].titik[2].y:=y1;
           obj[last_obj-1].titik[3].x:=x2;                          obj[last_obj-1].titik[3].y:=y2;
           obj[last_obj-1].titik[4].x:=x1+25;                     obj[last_obj-1].titik[4].y:=y2;
           obj[last_obj-1].jml_titik:=4;
           obj[last_obj-1].obj_type:='segilima';
           obj[last_obj-1].color:=clWhite;
           obj[last_obj-1].area.Create(x1,y1-40,x2+25,y2);
           obj[last_obj-1].style:=penstyle;
           obj[last_obj-1].ketebalah_garis:=SpinEdit3.Value;
           obj[last_obj-1].color_outline:=ColorButton1.ButtonColor;
           Tampil();
           selected_obj:=last_obj-1;
      end;
      if selected_btn = 'segienam' then
      begin
         SetLength(obj[last_obj-1].titik,6);
         obj[last_obj-1].titik[0].x:=x1;                        obj[last_obj-1].titik[0].y:=y1;
         obj[last_obj-1].titik[1].x:=(((x2-x1) div 2)+x1);      obj[last_obj-1].titik[1].y:=y1-40;
         obj[last_obj-1].titik[2].x:=x2;                        obj[last_obj-1].titik[2].y:=y1;
         obj[last_obj-1].titik[3].x:=x2;                        obj[last_obj-1].titik[3].y:=y2;
         obj[last_obj-1].titik[4].x:=(((x2-x1) div 2)+x1);      obj[last_obj-1].titik[4].y:=y2+40;
         obj[last_obj-1].titik[5].x:=x1;                        obj[last_obj-1].titik[5].y:=y2;
         obj[last_obj-1].jml_titik:=5;
         obj[last_obj-1].obj_type:='segienam';
         obj[last_obj-1].color:=clWhite;
         obj[last_obj-1].area.Create(x1,y1-40,x2,y2+40);
         obj[last_obj-1].style:=penstyle;  
           obj[last_obj-1].ketebalah_garis:=SpinEdit3.Value;
           obj[last_obj-1].color_outline:=ColorButton1.ButtonColor;
         Tampil();
         selected_obj:=last_obj-1;
      end;
      if selected_btn = 'garis' then
      begin
         SetLength(obj[last_obj-1].titik,2);
         obj[last_obj-1].titik[0].x:=x1;   obj[last_obj-1].titik[0].y:=y1;
         obj[last_obj-1].titik[1].x:=x2;   obj[last_obj-1].titik[1].y:=y2;
         obj[last_obj-1].jml_titik:=1;
         obj[last_obj-1].obj_type:='garis';
         obj[last_obj-1].color:=clWhite;
         obj[last_obj-1].style:=penstyle;
         Tampil();
         selected_obj:=last_obj-1;
      end;
  mousedownon:= false;
end;


procedure TForm1.btnZoomInClick(Sender: TObject);
begin
  for i:=0 to obj[selected_obj].jml_titik do
  begin
  obj[selected_obj].titik[i].x:=round(obj[selected_obj].titik[0].x+(abs(obj[selected_obj].titik[i].x - obj[selected_obj].titik[0].x)*1.5));
    obj[selected_obj].titik[i].y:= round(obj[selected_obj].titik[0].y+(abs(obj[selected_obj].titik[i].y - obj[selected_obj].titik[0].y)*1.5));
  end;
  Tampil();
end;

procedure TForm1.Arrow2Click(Sender: TObject);
begin
  for i:=0 to obj[selected_obj].jml_titik do
  begin
       obj[selected_obj].titik[i].y:=obj[selected_obj].titik[i].y-SpinEdit1.Value;
  end;
  if obj[selected_obj].obj_type='persegi' then
  begin
     obj[selected_obj].area.Create(obj[selected_obj].titik[0].x,obj[selected_obj].titik[0].y,obj[selected_obj].titik[2].x,obj[selected_obj].titik[2].y);
  end;
  if obj[selected_obj].obj_type='lingkaran' then
  begin
     obj[selected_obj].area.Create(obj[selected_obj].titik[0].x,obj[selected_obj].titik[0].y,obj[selected_obj].titik[obj[selected_obj].jml_titik].x,obj[selected_obj].titik[obj[selected_obj].jml_titik].y);
  end;

  Tampil();
end;

procedure TForm1.Arrow3Click(Sender: TObject);
begin
  for i:=0 to obj[selected_obj].jml_titik do
  begin
       obj[selected_obj].titik[i].y:=obj[selected_obj].titik[i].y+SpinEdit1.Value;
  end;
  if obj[selected_obj].obj_type='persegi' then
  begin
     obj[selected_obj].area.Create(obj[selected_obj].titik[0].x,obj[selected_obj].titik[0].y,obj[selected_obj].titik[2].x,obj[selected_obj].titik[2].y);
  end;
  if obj[selected_obj].obj_type='lingkaran' then
  begin
     obj[selected_obj].area.Create(obj[selected_obj].titik[0].x,obj[selected_obj].titik[0].y,obj[selected_obj].titik[obj[selected_obj].jml_titik].x,obj[selected_obj].titik[obj[selected_obj].jml_titik].y);
  end;
  Tampil();
end;

procedure TForm1.Arrow1Click(Sender: TObject);
begin
  for i:=0 to obj[selected_obj].jml_titik do
  begin
       obj[selected_obj].titik[i].x:=obj[selected_obj].titik[i].x-SpinEdit1.Value;
  end;
  if obj[selected_obj].obj_type='persegi' then
  begin
     obj[selected_obj].area.Create(obj[selected_obj].titik[0].x,obj[selected_obj].titik[0].y,obj[selected_obj].titik[2].x,obj[selected_obj].titik[2].y);
  end;
  if obj[selected_obj].obj_type='lingkaran' then
  begin
     obj[selected_obj].area.Create(obj[selected_obj].titik[0].x,obj[selected_obj].titik[0].y,obj[selected_obj].titik[obj[selected_obj].jml_titik].x,obj[selected_obj].titik[obj[selected_obj].jml_titik].y);
  end;
  Tampil();
end;

procedure TForm1.Arrow4Click(Sender: TObject);
begin
   for i:=0 to obj[selected_obj].jml_titik do
  begin
       obj[selected_obj].titik[i].x:=obj[selected_obj].titik[i].x+SpinEdit1.Value;
  end;
   if obj[selected_obj].obj_type='persegi' then
  begin
     obj[selected_obj].area.Create(obj[selected_obj].titik[0].x,obj[selected_obj].titik[0].y,obj[selected_obj].titik[2].x,obj[selected_obj].titik[2].y);
  end;
  if obj[selected_obj].obj_type='lingkaran' then
  begin
     obj[selected_obj].area.Create(obj[selected_obj].titik[0].x,obj[selected_obj].titik[0].y,obj[selected_obj].titik[obj[selected_obj].jml_titik].x,obj[selected_obj].titik[obj[selected_obj].jml_titik].y);
  end;
  Tampil();
end;

procedure TForm1.BitBtn11Click(Sender: TObject);
begin
  SetLength(obj,0);
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  last_obj:=0;
end;

procedure TForm1.BitBtn14Click(Sender: TObject);
begin
  selected_btn:='segitiga';
  StaticText1.Caption:=selected_btn;
end;

procedure TForm1.BitBtn15Click(Sender: TObject);
begin
  selected_btn:='segienam';
  StaticText1.Caption:=selected_btn;
end;

procedure TForm1.BitBtn16Click(Sender: TObject);
begin
  selected_btn:='garis';
  StaticText1.Caption:=selected_btn;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  selected_btn:='segilima';
  StaticText1.Caption:=selected_btn;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  selected_btn:='eraser';
  StaticText1.Caption:=selected_btn;
end;

procedure TForm1.btnPensilClick(Sender: TObject);
begin
  selected_btn:='pensil';
  StaticText1.Caption:=selected_btn;
end;

procedure TForm1.btnPersegiClick(Sender: TObject);
begin
  selected_btn:='persegi';
  StaticText1.Caption:=selected_btn;
end;


procedure TForm1.btnBucketClick(Sender: TObject);
begin
  selected_btn:='bucket';
  StaticText1.Caption:=selected_btn;
end;



procedure TForm1.BitBtn6Click(Sender: TObject);
var
  Temp:element;
  sdt:real;
begin
  TitikTengah(selected_obj);
  for i:=0 to obj[selected_obj].jml_titik do
  begin
    obj[selected_obj].titik[i].x := obj[selected_obj].titik[i].x - a;
    obj[selected_obj].titik[i].y := obj[selected_obj].titik[i].y - b;
    sdt := -SpinEdit2.Value*PI/180;
    Temp.x := Round(obj[selected_obj].titik[i].x*cos(sdt) - obj[selected_obj].titik[i].y*sin(sdt));
    Temp.y := Round(obj[selected_obj].titik[i].x*sin(sdt) + obj[selected_obj].titik[i].y*cos(sdt));
    obj[selected_obj].titik[i] := Temp;
    obj[selected_obj].titik[i].x := obj[selected_obj].titik[i].x+a;
    obj[selected_obj].titik[i].y := obj[selected_obj].titik[i].y+b;
  end;
  Tampil();
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
var
  Temp:element;
  sdt:real;
begin
  TitikTengah(selected_obj);
  for i:=0 to obj[selected_obj].jml_titik do
  begin
    obj[selected_obj].titik[i].x := obj[selected_obj].titik[i].x - a;
    obj[selected_obj].titik[i].y := obj[selected_obj].titik[i].y - b;
    sdt := SpinEdit2.Value*PI/180;
    Temp.x := Round(obj[selected_obj].titik[i].x*cos(sdt) - obj[selected_obj].titik[i].y*sin(sdt));
    Temp.y := Round(obj[selected_obj].titik[i].x*sin(sdt) + obj[selected_obj].titik[i].y*cos(sdt));
    obj[selected_obj].titik[i] := Temp;
    obj[selected_obj].titik[i].x := obj[selected_obj].titik[i].x+a;
    obj[selected_obj].titik[i].y := obj[selected_obj].titik[i].y+b;
  end;
  Tampil();
end;

procedure TForm1.btnLingkaranClick(Sender: TObject);
begin
  selected_btn:='lingkaran';
  StaticText1.Caption:=selected_btn;
end;

procedure TForm1.btnSelectClick(Sender: TObject);
begin
  selected_btn:='select';
  StaticText1.Caption:=selected_btn;
end;

procedure TForm1.btnZoomOutClick(Sender: TObject);
begin
  for i:=0 to obj[selected_obj].jml_titik do
  begin
  obj[selected_obj].titik[i].x:=round(obj[selected_obj].titik[0].x+(abs(obj[selected_obj].titik[i].x - obj[selected_obj].titik[0].x)*0.5));
    obj[selected_obj].titik[i].y:= round(obj[selected_obj].titik[0].y+(abs(obj[selected_obj].titik[i].y - obj[selected_obj].titik[0].y)*0.5));
  end;
  Tampil();
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
  0 : penstyle:=psSolid;
  1 : penstyle:=psDash;
  2 : penstyle:=psDot;
  3 : penstyle:=psDashDot;
  4 : penstyle:=psDashDotDot;
  end;
end;

procedure TForm1.Tampil();
var
     tengah:integer;
begin
  Image1.Canvas.Pen.Style:=psSolid;
       Image1.Canvas.Pen.Color:=clBlack;
       Image1.Canvas.Pen.Width:=1;
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  if selected_btn = 'pencerminan X' then
  begin
     tengah:=round(Image1.Height div 2);
     Image1.Canvas.MoveTo(0,tengah);
     Image1.Canvas.LineTo(Image1.Width,tengah);
  end;
  if selected_btn = 'pencerminan Y' then
  begin
     tengah:=round(Image1.Width div 2);
     Image1.Canvas.MoveTo(tengah,0);
     Image1.Canvas.LineTo(tengah,Image1.Width);
  end;
  if selected_btn = 'pencerminan XY' then
  begin
     Image1.Canvas.MoveTo(Image1.Width,0);
     Image1.Canvas.LineTo(0,Image1.Height);
  end;
  for i:= 0 to last_obj-1 do
     begin
       Image1.Canvas.Pen.Style:=obj[i].style; 
       Image1.Canvas.Pen.Color:=obj[i].color_outline;
       Image1.Canvas.Pen.Width:=obj[i].ketebalah_garis;
       if obj[i].obj_type = 'lingkaran' then
       begin
          Image1.Canvas.Ellipse(obj[i].titik[0].x,obj[i].titik[0].y,obj[i].titik[1].x,obj[i].titik[1].y);
       end
       else
       begin
          Image1.Canvas.MoveTo(obj[i].titik[obj[i].jml_titik].x,obj[i].titik[obj[i].jml_titik].y);
          for j:= 0 to obj[i].jml_titik do
          begin
               Image1.Canvas.LineTo(obj[i].titik[j].x,obj[i].titik[j].y);
          end;

       end;
       if obj[i].color <> clWhite then
       begin
          TitikTengah(i);
          BoundaryFill(a,b,Image1.Canvas.Pen.Color,obj[selected_obj].color);
       end;
     end;
     Image1.Refresh;
end;

procedure TForm1.TitikTengah(x:integer);
begin
  a:=0;b:=0;
  for i:=0 to obj[x].jml_titik do
  begin
    a := obj[x].titik[i].x + a;
    b := obj[x].titik[i].y + b;
  end;
  a := a div (obj[x].jml_titik+1);
  b := b div (obj[x].jml_titik+1);
end;


procedure TForm1.BoundaryFill(x, y, boundary, fill: Integer);
var
  current:Integer;
begin
  current:=Image1.Canvas.Pixels[x,y];
  if((current<>boundary) and (current<>fill)) then
  begin
    Image1.Canvas.Pixels[x,y]:=fill;
    BoundaryFill(x+1,y,boundary,fill);
    BoundaryFill(x-1,y,boundary,fill);
    BoundaryFill(x,y+1,boundary,fill);
    BoundaryFill(x,y-1,boundary,fill);
  end;
end;

procedure TForm1.SelectObjek(x , y:integer);
var
  point:TPoint;
begin
  point.x:=x;
  point.y:=y;
  for i:=0 to last_obj-1 do
  begin
    if PtInRect(obj[i].area,point) = true then
    begin
      selected_obj:=i;
      StaticText2.Caption:=IntToStr(selected_obj);
    end;
  end;
end;

end.

