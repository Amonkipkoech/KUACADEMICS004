report 40005 "Mrp Report 2 "
{

    DefaultLayout = RDLC;
    Caption = 'Assessment Card ';
    RDLCLayout = './MASTER ROTATION PLAN/reports/MasterRotation2.rdl';

    dataset
    {
        dataitem("Master Rotation Table"; "Master Rotation Plan2")
        {
            RequestFilterFields = "Plan ID", Year, Session;
            column(Plan_ID; "Plan ID")
            {
            }
            column(Year; Year)
            {
            }
            column(Session; Session)
            {
            }
            column(Department; Department)
            {
            }
            column(Phone_Number; "Phone Number")
            {
            }
            column(HoD_Name; "HoD Name")
            {
            }
            column(Start_Date; "Start Date")
            {
            }
            column(End_Date; "End Date")
            {

            }
            column(B2_Start_Date; "B2 Start Date")
            {

            }
            column(B2_End_Date; " B2 End Date")
            {
            }
            column(Leave_Start_Date__; "Leave Start Date  ")
            {
            }
            column(Leave_end_Date__; "Leave end Date  ")
            {
            }
            column(Category; Category)
            {
            }
            column(info_pic; info.Picture)
            {
            }
            column(info_name; info.Name)
            {
            }
            column(info_phone; info."Phone No.")
            {
            }
            column(info_mail; info."E-Mail")
            {
            }
            dataitem("End Of Block one Rotation"; "Clinical rotation")
            {
                DataItemLink = "Plan ID" = field("Plan ID");
                column(Department1; Department)
                {
                }
                column(Group1; Group)
                {
                }
                column(Areas1; Areas)
                {
                }
                column(No_Of_Students1; "No Of Students")
                {

                }
                column(Starting_Date1; "Starting Date")
                {
                }
                column(Ending_Date1; "Ending Date")
                {
                }

            }
            dataitem("Mrp Block Two Rotation Areas"; "Mrp Block Two Rotation Areas")//"Mrp Block Two Rotation Areas"
            {
                DataItemLink = "Plan ID" = field("Plan ID");
                column(Department2; Department)
                {

                }
                column(Group2; Group)
                {

                }
                column(Areas2; Areas)
                {

                }
                column(No_Std2; "No Std")
                {

                }
                column(Starting_Date2; "Starting Date")
                {
                }
                column(Ending_Date2; "Ending Date")
                {
                }
            }
            dataitem("Mrp End Of Leave Rotation "; "Mrp End Of Leave Rotation ")
            {
                DataItemLink = "Plan ID" = field("Plan ID");
                column(Department3; Department)
                {
                }
                column(Group3; Group)
                {
                }
                column(Areas3; Areas)
                {
                }
                column(No_Std; "No Std")
                {
                }
                column(Starting_Date; "Starting Date")
                {
                }
                column(Ending_Date; "Ending Date")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
            end;

        }
    }

    requestpage
    {
        layout
        {

        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnInitReport()
    begin
        info.RESET;
        IF info.FIND('-') THEN BEGIN
            info.CALCFIELDS(Picture);
        END;
    end;



    var
        myInt: Integer;
        seq: Integer;
        info: Record 79;
}
