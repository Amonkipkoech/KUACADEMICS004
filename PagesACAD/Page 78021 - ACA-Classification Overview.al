page 78021 "ACA-Classification Overview"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ACA-Course Registration";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programmes)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Year Of Study"; Rec."Year Of Study")
                {
                    ApplicationArea = All;
                }
                field("Maximum Year of Study"; Rec."Maximum Year of Study")
                {
                    ApplicationArea = All;
                }
                field("Final Graduation YoS"; Rec."Final Graduation YoS")
                {
                    ApplicationArea = All;
                }
                field("Graduation Group"; Rec."Graduation Group")
                {
                    ApplicationArea = All;
                }
                field("Yearly Graduating Units Count"; Rec."Yearly Graduating Units Count")
                {
                    ApplicationArea = All;
                }
                field("Yearly Grad. Req. Units"; Rec."Yearly Grad. Req. Units")
                {
                    ApplicationArea = All;
                }
                field("Final  Graduating Units Count"; Rec."Final  Graduating Units Count")
                {
                    ApplicationArea = All;
                }
                field("Final  Grad. Req. Units"; Rec."Final  Grad. Req. Units")
                {
                    ApplicationArea = All;
                }
                field("Is Final Year Student"; Rec."Is Final Year Student")
                {
                    ApplicationArea = All;
                }
                field("Yearly Graduating Marks"; Rec."Yearly Graduating Marks")
                {
                    ApplicationArea = All;
                }
                field("Final Graduating Marks"; Rec."Final Graduating Marks")
                {
                    ApplicationArea = All;
                }
                field("Yearly Graduating Average"; Rec."Yearly Graduating Average")
                {
                    ApplicationArea = All;
                }
                field("Final Graduating Average"; Rec."Final Graduating Average")
                {
                    ApplicationArea = All;
                }
                field("Yearly Grad. W. Average"; Rec."Yearly Grad. W. Average")
                {
                    ApplicationArea = All;
                }
                field("Final Grad. W.Average"; Rec."Final Grad. W.Average")
                {
                    ApplicationArea = All;
                }
                field("Yearly Grad. Weighted Units"; Rec."Yearly Grad. Weighted Units")
                {
                    ApplicationArea = All;
                }
                field("Final Grad. Weighted Units"; Rec."Final Grad. Weighted Units")
                {
                    ApplicationArea = All;
                }
                field("Final Grad. Year of Admission"; Rec."Final Grad. Year of Admission")
                {
                    ApplicationArea = All;
                }
                field("Exists Where Not Graduating"; Rec."Exists Where Not Graduating")
                {
                    ApplicationArea = All;
                }
                field("Yearly Passed (To Graduate)"; Rec."Yearly Passed (To Graduate)")
                {
                    ApplicationArea = All;
                }
                field("Final Passed (To Graduate)"; Rec."Final Passed (To Graduate)")
                {
                    ApplicationArea = All;
                }
                field("To Graduate"; Rec."To Graduate")
                {
                    ApplicationArea = All;
                }
                field("Reason not to Graduate"; Rec."Reason not to Graduate")
                {
                    ApplicationArea = All;
                }
                field("Final Clasification"; Rec."Final Clasification")
                {
                    ApplicationArea = All;
                }
                field("Graduation Academic Year"; Rec."Graduation Academic Year")
                {
                    ApplicationArea = All;
                }
                field("No. of Registrations"; Rec."No. of Registrations")
                {
                    ApplicationArea = All;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Final Stage"; Rec."Final Stage")
                {
                    ApplicationArea = All;
                }
                field("Yearly Total Units Taken"; Rec."Yearly Total Units Taken")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

