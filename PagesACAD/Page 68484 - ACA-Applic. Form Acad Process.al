page 68484 "ACA-Applic. Form Acad Process"
{
    DeleteAllowed = false;
    PageType = Document;
    SourceTable = "ACA-Applic. Form Header";
    SourceTableView = WHERE(Status = FILTER("Dean Approved" | "Dean Rejected"));

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("First Degree Choice"; Rec."First Degree Choice")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Second Degree Choice"; Rec."Second Degree Choice")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Admissable Status"; Rec."Admissable Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Documents)
            {
                Caption = 'Documents';
                action("Academic Background Subjects")
                {
                    Caption = 'Academic Background Subjects';
                    RunObject = Page 68471;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Professional Qualifications")
                {
                    Caption = 'Professional Qualifications';
                    RunObject = Page 68470;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Employment History")
                {
                    Caption = 'Employment History';
                    RunObject = Page 68469;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Academic Referees")
                {
                    Caption = 'Academic Referees';
                    RunObject = Page 68468;
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action("&View Details")
            {
                Caption = '&View Details';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 68521;
                RunPageLink = "Application No." = FIELD("Application No.");
                ApplicationArea = All;
            }
            action("&Process Applications")
            {
                Caption = '&Process Applications';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*Set the range for the records*/
                    Apps.RESET;
                    Apps.SETFILTER(Apps.Status, 'Dean Approved|Dean Rejected');
                    Apps.SETRANGE(Apps.Select, TRUE);
                    IF Apps.FIND('-') THEN BEGIN
                        /*Check if any records have been selected*/
                        IF Apps.COUNT = 0 THEN BEGIN
                            ERROR('No Application Forms selected for Processing');
                        END;
                    END
                    ELSE BEGIN
                        ERROR('No Application Forms selected for Processing');
                    END;
                    IF CONFIRM('A Total of ' + FORMAT(Apps.COUNT) + ' are about to be Processed.Continue?', TRUE) = FALSE THEN BEGIN EXIT END;
                    /*Get the new code*/
                    AppSetup.RESET;
                    AppSetup.GET();
                    NewCode := NoSeriesMgt.GetNextNo(AppSetup."Summary Application Nos.", 0D, TRUE);

                    /*Loop thru the records updating the status to Academic Division*/
                    REPEAT
                        Apps."Batch No." := NewCode;
                        Apps."Batch Date" := TODAY;
                        Apps."Batch Time" := TIME;
                        Apps.Status := Apps.Status::"Admission Board";
                        Apps."Admissable Status" := 'ADMISSABLE';
                        Apps.MODIFY;
                    UNTIL Apps.NEXT = 0;
                    AppBatch.RESET;
                    AppBatch.INIT;
                    AppBatch."Batch No." := NewCode;
                    AppBatch."Batch Date" := TODAY;
                    AppBatch."Batch Time" := TIME;
                    AppBatch.INSERT;
                    /*Alert the user that the applications have been moved to a particular batch*/
                    MESSAGE('The Selected Applications have been moved to the Batch ' + FORMAT(NewCode));

                end;
            }
        }
    }

    var
        Apps: Record "ACA-Applic. Form Header";
        AppBatch: Record "ACA-Adm. Form Batch";
        IntC: Integer;
        NoSeriesMgt: Codeunit 396;
        NewCode: Code[20];
        AppSetup: Record 61367;
}

