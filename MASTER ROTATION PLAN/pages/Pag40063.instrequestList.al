page 40063 "Institution Request List"
{
    PageType = List;
    CardPageId = "Institution Request Card";
    SourceTable = "Institutional Request";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Request Number"; "Request Number") { }
                field("Institution Name"; "Institution Name") { }
                field(Semester; Semester) { }
                field("Academic Year"; "Academic Year") { }
                field(Status; Status) { }
            }
        }
    }
}
