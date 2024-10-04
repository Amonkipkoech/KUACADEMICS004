report 78057 "ACA-Attendance Statistics"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACAATTENDANCESTATISTICS.rdl';

    dataset
    {

        dataitem(cad; "Class Attendance Details")
        {
            RequestFilterFields = Semester, "Unit Code";

            column(Semester_cad;
            Semester)
            {
            }
            column(AttendanceDate_cad; "Attendance Date")
            {
            }
            column(LecturerCode_cad; "Lecturer Code")
            {
            }
            column(StudentNo_cad; "Student No.")
            {
            }
            column(UnitCode_cad; "Unit Code")
            {
            }
            column(StudentName_cad; "Student Name")
            {
            }
            column(Present_cad; Present)
            {
            }
            column(Counting_cad; Counting)
            {
            }
            column(totalClasses; totalClasses)
            {

            }
            column(attended; attended)
            {

            }
            column(skipped; skipped)
            {

            }
            column(percentAbsent; percentAbsent)
            {

            }
            column(percentAttend; percentAttend)
            {

            }
            column(logo; info.Picture)
            {

            }
            column(compname; info.Name)
            {

            }
            column(compAddress; info.Address)
            {

            }
            column(CompEmail; info."E-Mail")
            {

            }
            column(compUrl; info."Home Page")
            {

            }
            column(studName; studName)
            {

            }
            column(unitName; unitName)
            {

            }
            trigger OnPreDataItem()
            begin
                info.get;
                info.CalcFields(Picture);

                // totalClasses := 0;
                //attended := 0;
                // skipped := 0;

            end;

            trigger OnAfterGetRecord()
            begin


                attendance.Reset();
                attendance.SetRange(attendance.Semester, cad.Semester);
                attendance.SetRange(attendance."Unit Code", cad."Unit Code");
                attendance.SetRange(attendance."Student No.", cad."Student No.");
                if attendance.Find('-') then begin
                    attendance.CalcFields("Total Classes", "Absent Counting", "Present Counting");
                    //repeat
                    totalClasses := attendance."Total Classes";
                    attended := attendance."Present Counting";
                    skipped := attendance."Absent Counting";
                    //until attendance.Next() = 0;
                    cust.Reset();
                    cust.SetRange("No.", "Student No.");
                    if cust.Find('-') then begin
                        studName := cust.Name;
                    end;
                    unitsubj.Reset();
                    unitsubj.SetRange(Code, "Unit Code");
                    if unitsubj.find('-') then begin
                        unitName := unitsubj.Desription;
                    end;
                end;

                percentAttend := Round((attended / totalClasses) * 100, 0.2);
                percentAbsent := Round((skipped / totalClasses) * 100, 0.2);

                // studunits.Reset();
                // studunits.SetRange("Student No.", cad."Student No.");
                // studunits.SetRange(Semester, cad.Semester);
                // studunits.SetRange(Unit, cad."Unit Code");
                // if studunits.Find('-') then begin
                //     repeat

                //     until studunits.Next() = 0;
                // end;
            end;


        }

    }

    var
        attendance: Record "Class Attendance Details";
        totalClasses: Decimal;
        attended: Decimal;
        skipped: Decimal;
        percentAttend: Decimal;
        percentAbsent: Decimal;
        info: Record "Company Information";
        cust: Record Customer;
        studName: Text;
        unitName: Text;
        unitsubj: Record "ACA-Units/Subjects";
        studunits: Record "ACA-Student Units";
}