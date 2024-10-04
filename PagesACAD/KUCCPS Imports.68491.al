page 68491 "KUCCPS Imports"
{
    PageType = List;
    SourceTable = 70082;
    SourceTableView = WHERE(Processed = FILTER(false));
    PromotedActionCategories = 'New,Process,Report,Import,Mail Management';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ser; Rec.ser)
                {
                    ApplicationArea = All;
                }
                field("KUCCPS Batch"; Rec."KUCCPS Batch")
                {
                    ApplicationArea = All;
                }
                field(Notified; Rec.Notified)
                {
                    ApplicationArea = All;
                }
                field(Index; Rec.Index)
                {
                    ApplicationArea = All;
                }
                field(Admin; Rec.Admin)
                {
                    ApplicationArea = All;
                }
                field(Prog; Rec.Prog)
                {
                    ApplicationArea = All;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                field("Alt. Phone"; Rec."Alt. Phone")
                {
                    ApplicationArea = All;
                }
                field(Box; Rec.Box)
                {
                    ApplicationArea = All;
                }
                field(Codes; Rec.Codes)
                {
                    ApplicationArea = All;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Slt Mail"; Rec."Slt Mail")
                {
                    ApplicationArea = All;
                }
                field("Campus Location"; Rec."Campus Location")
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
            group("&Functions")
            {
                // Caption = '&Functions';
                /* action(ProcessAdmissions)
                {
                    Caption = '&Process Admissions';
                    Image = ExecuteBatch;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ACAAdmImportedJABBuffer: Record 70082;
                    begin
                        IF CONFIRM('Process Selected Student?', TRUE) = FALSE THEN BEGIN
                            REPORT.RUN(51348, TRUE, TRUE);
                        END ELSE BEGIN
                            ACAAdmImportedJABBuffer.RESET;
                            ACAAdmImportedJABBuffer.SETRANGE(ser, Rec.ser);
                            IF ACAAdmImportedJABBuffer.FIND('-') THEN BEGIN
                                REPORT.RUN(51348, FALSE, FALSE, ACAAdmImportedJABBuffer);
                            END;
                        END;
                        CurrPage.UPDATE;
                    end;
                } */
                action(Import)
                {
                    Caption = 'Import';
                    Image = Import;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    begin
                        IF CONFIRM('Import KUCCPS Students', TRUE) = FALSE THEN EXIT;
                        XMLPORT.RUN(50187, FALSE, TRUE);
                    end;
                }
                /*    action(Print)
                   {
                       Caption = 'Print';
                       ApplicationArea = All;
                       Promoted = true;
                       PromotedCategory = Report;

                       trigger OnAction()
                       begin
                           KUCCPSImports.RESET;
                           KUCCPSImports.SETFILTER(KUCCPSImports.Index, Rec.Index);
                           REPORT.RUN(51343, TRUE, TRUE, KUCCPSImports);
                       end;
                   } */
            }
        }
    }

    var

        KUCCPSImports: Record 70082;


    /// <summary>
    /// SplitNames.
    /// </summary>
    /// <param name="Names">VAR Text[100].</param>
    /// <param name="Surname">VAR Text[50].</param>
    /// <param name="Other Names">VAR Text[50].</param>
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

