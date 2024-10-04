report 51777 "Population By Campus"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Population By Campus.rdl';

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = WHERE("Dimension Code" = FILTER(''));
            column(DimName; Name)
            {
            }
            column(CampTotalNew; CampTotalNew)
            {
            }
            column(CampTotalContinuing; CampTotalContinuing)
            {
            }
            column(CampTotal; CampTotal)
            {
            }
            column(GrandTotalNew; GrandTotalNew)
            {
            }
            column(GrandTotalCont; GrandTotalCont)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            dataitem("ACA-Exam Category"; "ACA-Exam Category")
            {
                DataItemTableView = SORTING(Series, Code)
                                    ORDER(Ascending);
                column(Title1; 'STUDENT POPULATION PER CAMPUS AS AT ' + FORMAT(TODAY, 0, 4) + ', ' + Sems)
                {
                }
                column(ExamCode; Code)
                {
                }
                column(CATNew; CATNew1)
                {
                }
                column(CATContinuing; CATContinuing1)
                {
                }
                column(CATTotal; CATTotal1)
                {
                }
                column(pic; info.Picture)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    CLEAR(CATTotal1);
                    CLEAR(CATContinuing1);
                    CLEAR(CATNew1);
                    CLEAR(CATTotal);
                    CLEAR(CATContinuing);
                    CLEAR(CATNew);

                    courseReg.RESET;
                    courseReg.SETRANGE(courseReg.Semester, Sems);
                    //  courseReg.SETRANGE(courseReg."Academic Year",acadyear);
                    courseReg.SETRANGE(courseReg."Campus Code", "Dimension Value".Code);
                    courseReg.SETRANGE(courseReg."Programme Exam Category", "ACA-Exam Category".Code);
                    courseReg.SETRANGE(courseReg.Stage, 'Y1S1');
                    IF courseReg.FIND('-') THEN BEGIN
                        CATNew1 := courseReg.COUNT;
                        CampTotal1 := CampTotal1 + (courseReg.COUNT);
                        GrandTotal1 := GrandTotal1 + (courseReg.COUNT);
                        GrandTotalNew1 := GrandTotalNew1 + (courseReg.COUNT);
                        CampTotalNew1 := CampTotalNew1 + (courseReg.COUNT);
                    END;

                    // Pick Continuing Students
                    courseReg.RESET;
                    courseReg.SETRANGE(courseReg.Semester, Sems);
                    //courseReg.SETRANGE(courseReg."Academic Year",acadyear);
                    courseReg.SETRANGE(courseReg."Campus Code", "Dimension Value".Code);
                    courseReg.SETRANGE(courseReg."Programme Exam Category", "ACA-Exam Category".Code);
                    courseReg.SETFILTER(courseReg.Stage, '<>Y1S1');
                    IF courseReg.FIND('-') THEN BEGIN
                        CATContinuing1 := courseReg.COUNT;
                        CampTotal1 := CampTotal1 + (courseReg.COUNT);
                        GrandTotal1 := GrandTotal1 + (courseReg.COUNT);
                        GrandTotalCont1 := GrandTotalCont1 + (courseReg.COUNT);
                        ;
                        CampTotalContinuing1 := CampTotalContinuing1 + (courseReg.COUNT);
                    END;

                    CATTotal1 := CATNew1 + CATContinuing1;


                    IF CampTotal1 <> 0 THEN CampTotal := FORMAT(CampTotal1);
                    IF CampTotalNew1 <> 0 THEN CampTotalNew := FORMAT(CampTotalNew1);
                    IF CampTotalContinuing1 <> 0 THEN CampTotalContinuing := FORMAT(CampTotalContinuing1);
                    IF GrandTotalNew1 <> 0 THEN GrandTotalNew := FORMAT(GrandTotalNew1);
                    IF GrandTotalCont1 <> 0 THEN GrandTotalCont := FORMAT(GrandTotalCont1);
                    IF GrandTotal1 <> 0 THEN GrandTotal := FORMAT(GrandTotal1);
                    IF CATTotal1 <> 0 THEN CATTotal := FORMAT(CATTotal1);
                    IF CATContinuing1 <> 0 THEN CATContinuing := FORMAT(CATContinuing1);
                    IF CATNew1 <> 0 THEN CATNew := FORMAT(CATNew1);
                end;
            }

            trigger OnAfterGetRecord()
            begin

                CLEAR(CampTotal1);
                CLEAR(CampTotalNew1);
                CLEAR(CampTotalContinuing1);
                CLEAR(CampTotal);
                CLEAR(CampTotalNew);
                CLEAR(CampTotalContinuing);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Semz; Sems)
                {
                    Caption = 'Semester:';
                    TableRelation = "ACA-Semesters".Code;
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        IF info.GET() THEN Sems := info."Last Semester Filter";
    end;

    trigger OnPreReport()
    begin

        info.RESET;
        IF info.FIND('-') THEN info.CALCFIELDS(Picture);
        CLEAR(GrandTotalNew1);
        CLEAR(GrandTotalCont1);
        CLEAR(GrandTotal1);
        CLEAR(GrandTotalNew);
        CLEAR(GrandTotalCont);
        CLEAR(GrandTotal);


        IF ((Sems <> '')) THEN
            acayrNsem := 'Semester: ' + Sems
        ELSE
            acayrNsem := '';


        info.RESET;
        IF info.FIND('-') THEN BEGIN
            info.CALCFIELDS(Picture);
        END;
    end;

    var
        info: Record 79;
        acadyear: Code[20];
        Sems: Code[20];
        courseReg: Record 61532;
        acayrNsem: Code[50];
        CampTotal1: Integer;
        CampTotalNew1: Integer;
        CampTotalContinuing1: Integer;
        GrandTotalNew1: Integer;
        GrandTotalCont1: Integer;
        GrandTotal1: Integer;
        CATTotal1: Integer;
        CATContinuing1: Integer;
        CATNew1: Integer;
        CampTotal: Code[10];
        CampTotalNew: Code[10];
        CampTotalContinuing: Code[10];
        GrandTotalNew: Code[10];
        GrandTotalCont: Code[10];
        GrandTotal: Code[10];
        CATTotal: Code[10];
        CATContinuing: Code[10];
        CATNew: Code[10];
}

