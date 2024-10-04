page 68487 "ACA-Applic. Form Board Process"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "ACA-Applic. Form Header";
    SourceTableView = WHERE(Status = FILTER(<> Approved));

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
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Caption = 'Year';
                    ApplicationArea = All;
                }
                field("Admitted Degree"; Rec."Admitted Degree")
                {
                    Caption = 'Programme';
                    ApplicationArea = All;
                }
                field("Admitted To Stage"; Rec."Admitted To Stage")
                {
                    Caption = 'Stage';
                    ApplicationArea = All;
                }
                field("Admitted Semester"; Rec."Admitted Semester")
                {
                    Caption = 'Semester';
                    ApplicationArea = All;
                }
                field("Date Of Meeting"; Rec."Date Of Meeting")
                {
                    ApplicationArea = All;
                }
                field("Admission Board Recommendation"; Rec."Admission Board Recommendation")
                {
                    ApplicationArea = All;
                }
                field("Deferred Until"; Rec."Deferred Until")
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
                    Image = History;
                    RunObject = Page "ACA-Application Form Academic";
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Professional Qualifications")
                {
                    Caption = 'Professional Qualifications';
                    Image = ProfileCalender;
                    RunObject = Page "ACA-Application Form Qualif.";
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Employment History")
                {
                    Caption = 'Employment History';
                    Image = Employee;
                    RunObject = Page "ACA-Application Form Employ.";
                    RunPageLink = "Application No." = FIELD("Application No.");
                    ApplicationArea = All;
                }
                action("Academic Referees")
                {
                    Caption = 'Academic Referees';
                    Image = CustomerContact;
                    RunObject = Page "ACA-Application Form Acad. Ref";
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
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 68488;
                RunPageLink = "Application No." = FIELD("Application No.");
                ApplicationArea = All;
            }
            group("&Functions")
            {
                Caption = '&Functions';
                action("&Mark as Ratified")
                {
                    Caption = '&Mark as Ratified';
                    Image = Approve;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*Set the range for the records to be used*/
                        Apps.RESET;
                        //Apps.SETRANGE(Apps.Status,Apps.Status::"Admission Board");
                        Apps.SETRANGE(Apps.Select, TRUE);
                        Apps.SETFILTER(Apps.Status, '<>%1', Apps.Status::Approved);
                        /*Check if there are any records*/
                        IF Apps.COUNT < 1 THEN BEGIN
                            ERROR('No Application records selected for the selected operation');
                        END;
                        IF Apps.FIND('-') THEN BEGIN
                            REPEAT
                                /*Check if the record has all the required details*/
                                IF Apps."Admitted Degree" = '' THEN BEGIN
                                    ERROR('An Application is being ratified without the Degree Course to be admitted to being selected.Process Aborted');
                                END;
                                IF Rec."Date Of Meeting" = 0D THEN BEGIN
                                    ERROR('The Admissions Board Date Of Meeting has to be inserted.Process aborting');
                                END;
                                Apps.Status := Apps.Status::Approved;
                                Apps.VALIDATE(Apps.Status);
                                Apps."Admission Board Date" := TODAY;
                                Apps."Admission Board Time" := TIME;
                                Rec."Admit/NotAdmit" := 'Admit';
                                Apps.MODIFY;
                            UNTIL Apps.NEXT = 0;
                        END;
                        MESSAGE('The Selected Application request have been marked as Ratified');

                    end;
                }
                action("&Mark as Not Ratified")
                {
                    Caption = '&Mark as Not Ratified';
                    Image = Reject;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*Set the range for the records to be used*/
                        Apps.RESET;
                        Apps.SETRANGE(Apps.Status, Apps.Status::"Admission Board");
                        Apps.SETRANGE(Apps.Select, TRUE);
                        /*Check if there are any records*/
                        IF Apps.COUNT < 1 THEN BEGIN
                            ERROR('No Application records selected for the selected operation');
                        END;
                        IF Apps.FIND('-') THEN BEGIN
                            REPEAT
                                Apps.Status := Apps.Status::"Admission Board Rejected";
                                Apps."Admission Board Date" := TODAY;
                                Apps."Admission Board Time" := TIME;
                                Apps.MODIFY;
                            UNTIL Apps.NEXT = 0;
                        END;
                        MESSAGE('The Selected Application request have been marked as Not Ratified');

                    end;
                }
            }
        }
    }

    var
        Apps: Record "ACA-Applic. Form Header";
}

