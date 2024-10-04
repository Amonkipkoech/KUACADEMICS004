/// <summary>
/// Page ACA-Processed GOK Admn Buffer (ID 68511).
/// </summary>
page 68511 "ACA-Processed GOK Admn Buffer"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ACA-Applic Form PostGraduate";
    //SourceTableView = WHERE(Field16 = CONST(Yes));

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Print Admission Letter")
            {
                Caption = '&Print Admission Letter';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;


            }
        }
    }

    var
        JAB: Record "ACA-Applic Form PostGraduate";
        Admissions: Record "ACA-Adm. Form Header";
        AdminSetup: Record "ACA-Adm. Number Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        AdminCode: Code[20];

    procedure SplitNames(var Names: Text[100]; var Surname: Text[50]; var "Other Names": Text[50])
    var
        lngPos: Integer;
    begin
        /*Get the position of the space character*/
        lngPos := STRPOS(Names, ' ');
        IF lngPos <> 0 THEN BEGIN
            Surname := COPYSTR(Names, 1, lngPos - 1);
            "Other Names" := COPYSTR(Names, lngPos + 1);
        END;

    end;
}

