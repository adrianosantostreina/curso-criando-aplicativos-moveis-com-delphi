unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls;

type
  TForm2 = class(TForm)
    img1: TImage;
    lyt1: TLayout;
    BlurEffect1: TBlurEffect;
    rct1: TRectangle;
    lyt2: TLayout;
    lyt3: TLayout;
    Circle2: TCircle;
    ShadowEffect1: TShadowEffect;
    lyt4: TLayout;
    lyt5: TLayout;
    lyt6: TLayout;
    lyt7: TLayout;
    lyt8: TLayout;
    lyt9: TLayout;
    rct2: TRectangle;
    rct3: TRectangle;
    edt1: TEdit;
    StyleBook1: TStyleBook;
    edt2: TEdit;
    rct4: TRectangle;
    btn1: TSpeedButton;
    Text1: TText;
    Text2: TText;
    rct5: TRectangle;
    btn2: TSpeedButton;
    rct6: TRectangle;
    btn3: TSpeedButton;
    Path1: TPath;
    Path2: TPath;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

end.
