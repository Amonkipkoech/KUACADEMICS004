page 68169 "ACA-Stud. Online Profile"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = true;
    ModifyAllowed = false;
    PageType = Document;
    PopulateAllFields = false;
    ShowFilter = false;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Image)
                {
                    ApplicationArea = All;
                }
            }
            group("Registered Units")
            {
                Caption = 'Registered Units';
                part("."; 68712)
                {
                    Caption = '.';
                    Editable = false;
                    SubPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Infor)
            {
                action("Fee Statement")
                {
                    Image = Statistics;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Cust.RESET;
                        Cust.SETFILTER(Cust."No.", Rec."No.");
                        IF Cust.FIND('-') THEN
                            REPORT.RUN(39004664, TRUE, TRUE, Cust);
                    end;
                }
                separator(_______)
                {
                }
                action("Hostel Booking")
                {
                    Image = Holiday;
                    RunObject = Page 68205;
                    RunPageLink = Student = FIELD("No."),
                                  Billed = CONST(false),
                                  Cleared = CONST(false);
                    ApplicationArea = All;
                }

                action("Units Registration")
                {
                    Image = UnitConversions;
                    ApplicationArea = All;
                    // RunObject = Page 68818;
                    //  RunPageLink = Cleared = FIELD("No.");
                }

                action("Club Registration")
                {
                    Image = CapableToPromise;
                    ApplicationArea = All;
                }

                action("Exam Results")
                {
                    Image = OpenWorksheet;
                    RunObject = Page "ACA-Stud. Online Results";
                    RunPageLink = "Student No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.SETRANGE("No.", StudentNo);
    end;

    trigger OnOpenPage()
    begin
        StudentNo := Rec."No.";
    end;

    var
        StudentNo: Code[20];
        Cust: Record Customer;
}

