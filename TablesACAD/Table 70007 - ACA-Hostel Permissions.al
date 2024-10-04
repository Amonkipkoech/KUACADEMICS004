table 70007 "ACA-Hostel Permissions"
{

    fields
    {
        field(1; "User Id"; Code[30])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(2; "Can Allocate Room"; Boolean)
        {
        }
        field(3; "Can Check-Out"; Boolean)
        {
        }
        field(4; "Can Switch Room"; Boolean)
        {
        }
        field(5; "Can Transfer Student"; Boolean)
        {
        }
        field(6; "Can Reverse Allocation"; Boolean)
        {
        }
        field(7; "Can Print Invoice"; Boolean)
        {
        }
        field(8; "Can Create Hostel"; Boolean)
        {
        }
        field(9; "Can Create Room"; Boolean)
        {
        }
        field(10; "Can Create Room Space"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "User Id")
        {
        }
    }

    fieldgroups
    {
    }

    procedure PermissionMan(UserSent: Text[30]; PermissionCode: Option " ",Allocation,"Check-out",Switch,Transfer,Reverse,Print,"Create Hostel","Create Room","Create Space")
    var
        ACAHostelPermissions: Record 70007;
    begin
        /*ACAHostelPermissions.RESET;
        ACAHostelPermissions.SETRANGE("User Id",UserSent);
        IF ACAHostelPermissions.FIND('-') THEN BEGIN
          IF PermissionCode=PermissionCode::Allocation THEN IF ACAHostelPermissions."Can Allocate Room"=FALSE THEN ERROR('Access Denied');
          IF PermissionCode=PermissionCode::"Check-out" THEN IF ACAHostelPermissions."Can Check-Out"=FALSE THEN ERROR('Access Denied');
          IF PermissionCode=PermissionCode::Switch THEN IF ACAHostelPermissions."Can Switch Room"=FALSE THEN ERROR('Access Denied');
          IF PermissionCode=PermissionCode::Transfer THEN IF ACAHostelPermissions."Can Transfer Student"=FALSE THEN ERROR('Access Denied');
          IF PermissionCode=PermissionCode::Reverse THEN IF ACAHostelPermissions."Can Reverse Allocation"=FALSE THEN ERROR('Access Denied');
          IF PermissionCode=PermissionCode::Print THEN IF ACAHostelPermissions."Can Print Invoice"=FALSE THEN ERROR('Access Denied');
          IF PermissionCode=PermissionCode::"Create Hostel" THEN IF ACAHostelPermissions."Can Create Hostel"=FALSE THEN ERROR('Access Denied');
          IF PermissionCode=PermissionCode::"Create Room" THEN IF ACAHostelPermissions."Can Create Room"=FALSE THEN ERROR('Access Denied');
          IF PermissionCode=PermissionCode::"Create Space" THEN IF ACAHostelPermissions."Can Create Room Space"=FALSE THEN ERROR('Access Denied');
          END ELSE ERROR('Access Denied');
          */

    end;
}

