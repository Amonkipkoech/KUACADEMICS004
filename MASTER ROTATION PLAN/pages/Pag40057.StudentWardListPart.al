page 40057 "Student Ward ListPart"
{
    Caption = 'Student Ward ListPart';
    PageType = ListPart;
    SourceTable = "Student Ward Line";



    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(StudentNo; REC.StudentNo) { }
                field(GroupId; REC.GroupId) { }
                field("Rotation Ward Area"; rec."Rotation Ward Area") { }
                field("Rotation Ward Name"; rec."Rotation Ward Name") { }
                field("Rotation Area"; rec."Rotation Area") { }
                field("Start Date"; rec."Start Date") { }
                field("End Date"; rec."End Date") { }
                field(Attendance; rec.Attendance) { }
                field(Achievements; rec.Achievements) { }
                field(Comment; rec.Comment) { }
            }
        }
    }
}
