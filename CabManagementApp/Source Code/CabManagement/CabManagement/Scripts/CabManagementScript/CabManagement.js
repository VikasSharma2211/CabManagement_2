

function CabDetails(VendorID, VendorName, CabNumberFirst, CabNumberLast, CabType, CabCapacity, DriverName, EmpanelDate, lstCabProperty, DocumentsVerified, IsActive,IsActiveComment,CabID) {
          this.VendorID = VendorID;
          this.VendorName = VendorName;
          this.CabNumberFirst = CabNumberFirst;
          this.CabNumberLast = CabNumberLast;
          this.CabType = CabType;
          this.CabCapacity = CabCapacity;
          this.DriverName = DriverName;
          this.EmpanelDate = EmpanelDate;
          this.lstCabProperty = lstCabProperty;
          this.DocumentsVerified = DocumentsVerified;
          this.IsActive = IsActive;
          this.IsActiveComment = IsActiveComment;
          this.CabId = CabID;
             
      }

function CabProperty(PropertyId, ExpiryDate)
{
    this.PropertyId = PropertyId;
    this.ExpiryDate = ExpiryDate;
}
         
$(document).ready(function () {
    $("#frmcabdetail").validationEngine();
    $("#pageloaddiv").fadeIn(1000);
    $('#overlay-back').fadeIn(1000);
             
    $("#pageloaddiv").fadeOut(500);
    $('#overlay-back').fadeOut(500);
    //end code to load active all vendor list
    GetCabVendorList();
    GetCabType();
    GetCabCapacity();
    GetCabProperty();
    GetCabDetail();

    $("#txtEmpanelDate").datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: "M dd,yy",
        maxDate: new Date(),
        readonly: true
    });
                 
    //to show popup to create a new vendor           
    $("#aCreatCabDetail").click(function () {
        //hide validation message if any
        $("#frmcabdetail").validationEngine('hideAll');
        //hide update button and show submit button
        $("#btnSubmit").show();
        $("#btnUpdate").hide();

        $('#overlay-back').fadeIn(100, function () {
            $('#popup').show();
            ClearCabDetail();
        });
    });

    //delete selected CabDetail
    $("#aDeleteCabDetail").click(function () {
        var SelectedCabId = "";
               
        var countchecked = $("#tblLstCabDetail input[type=checkbox]:checked").length;

        if (countchecked > 0) {
            if (confirm("Are you sure to delete the selected " + countchecked + " Cab?")) {
                // continue with delete
                var chkSelected = $("#tblLstCabDetail input[type=checkbox]:checked");
                for (var index = 0; index < countchecked; index++) {
                    var id = chkSelected[index].attributes["id"].value.substring(3);
                    SelectedCabId += id + ",";
                }
                if (SelectedCabId != "") {
                    SelectedCabId = SelectedCabId.substring(0, SelectedCabId.length - 1);
                    $.ajax({
                        type: "POST",
                        url: "CabManagement.aspx/DeleteSelectedCab",
                        data: "{'CabId':'" + SelectedCabId + "','Comment':''}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            var msg = result.d;
                            if (msg) {
                                ClearCabDetail();
                                GetCabDetail();
                            }
                            else {
                                alert("Error Occured");
                            }

                        },
                        error: function (er) {
                            alert(er);
                        }
                    })
                }

            }
        }
        else {
            alert("Select atleast 1 Cab to delete!!!");
        }

    });


    $(".close-image").on('click', function () {
        $('#popup').hide();
        $('#overlay-back').fadeOut(100);
    });
            
    $("#btnCancel").on('click', function () {
        $('#popup').hide();
        $('#overlay-back').fadeOut(100);
        ClearCabDetail();
    });
    $("#frmcabdetail").submit(function (e) {

               
        var valid = $("#frmcabdetail").validationEngine('validate');
        if (valid) {
            e.preventDefault();
            InsertCabDetail();
        }
    });

    //to update existing vendor
    $("#btnUpdate").on('click', function () {
              
        var valid = $("#frmcabdetail").validationEngine('validate');
        if (valid) {
            var objVendor = new CabDetails();
            objVendor.CabId = $("#hdnCabId").text();
            objVendor.VendorID = $("#ddlVenderName").val();
            objVendor.VendorName = $("#ddlVenderName").text;
            objVendor.CabNumberFirst = $("#txtcabnofirst").val();
            objVendor.CabNumberLast = $("#txtcabnolast").val();
            objVendor.CabType = $("#ddlcabtype").val();
            objVendor.CabCapacity = $("#ddlcarcapacity").val();
            objVendor.DriverName = $("#txtdrivername").val();
            objVendor.EmpanelDate = $("#txtEmpanelDate").val();
            objVendor.IsActiveComment = $("#txtComment").val();
            var property = [];
                    
            for (i = 0; i < counter; i++) {

                var PropID = $('#hdPropertyId' + i).val();
                var PropExpDate = $('#chklistitem_text' + i).val();

                property.push(new CabProperty(PropID, PropExpDate));
                if (PropExpDate != '') {
                    objVendor.DocumentsVerified = 'true';
                    objVendor.IsActive = 'true';
                }


            }
            objVendor.lstCabProperty = property;
            $.ajax({
                type: "POST",
                url: "CabManagement.aspx/UpdateCabDetail",
                data: "{'cabManagement':" + JSON.stringify(objVendor) + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var msg = result.d;
                    if (msg) {
                              
                        $('#popup').hide();
                        $('#overlay-back').fadeOut(100);
                        GetCabDetail();
                        ClearCabDetail();
                    }
                    else {
                        alert("Error Occured");
                    }

                },
                error: function (er) {
                    alert(er);
                }
            })
        }
    });

});
                  
function GetCabVendorList() {
    $.ajax({
        type: "POST",
        url: "CabManagement.aspx/GetVendorList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            var dcJSON = result.d;
            if (dcJSON != null) {
                $.each(dcJSON, function (index, value) {
                    $('#ddlVenderName').append($("<option></option>").val(value.VendorID).html(value.VendorName));
                });
            }
        },
        error: function (er) {
            alert(er);
        }
    });
}
                  
function GetCabType() {
            
    $.ajax({
        type: "POST",
        url: "CabManagement.aspx/GetCabType",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            var dcJSON = result.d;
            if (dcJSON != null) {
                $.each(dcJSON, function (index, value) {
                    $('#ddlcabtype').append($("<option></option>").html(value.CABNAME));
                });
            }
        },
        error: function (er) {
            alert(er);
        }
    });
}
         
function GetCabCapacity() {
    $.ajax({
        type: "POST",
        url: "CabManagement.aspx/GetCabCapacity",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            var dcJSON = result.d;
            if (dcJSON != null) {
                $.each(dcJSON, function (index, value) {
                    $('#ddlcarcapacity').append($("<option></option>").html(value.capacity));
                });
            }
        },
        error: function (er) {
            alert(er);
        }
    });
}

function GetCabProperty() {
    $.ajax({
        type: "POST",
        url: "CabManagement.aspx/GetCabProperty",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            var dcJSON = result.d;
            if (dcJSON != null) {
                        
                CreateCheckBoxList(dcJSON);
            }
        },
        error: function (er) {
            alert(er);
        }
    });
}

var counter = 0;
function CreateCheckBoxList(checkboxlistItems) {
    var table = $('<table></table>');
    // var counter = 0;
    $(checkboxlistItems).each(function () {
        table.append($('<tr></tr>').append($('<td></td>').append($('<input>').attr({
            type: 'hidden', name: 'hdPropertyId', value: this.PropertyId, id: 'hdPropertyId' + counter,
            //type: 'checkbox', name: 'chklistitem', value: this.PropertyId, id: 'chklistitem' + counter,
                                       
        })).append(
        $('<label>').attr({
            for: 'hdPropertyId_label' + counter
        }).text(this.PropertyName)))


        .append($('<td style="padding-left:20px"></td>').append($('<input>').attr({
            type: 'text',  id: 'chklistitem_text' + counter,class:'datepick'
                                              

        }))
                               
        )

        );
                
        counter++;
    });

    $('#dvCheckBoxListControl').append(table);
    // 
    // var a =$('#chklistitem_text0');
    $(".datepick").datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: "M dd,yy",
        maxDate: new Date(),
        readonly: true
    });
          
           
}
         
function InsertCabDetail()
{
            
    var objVendor = new CabDetails();
    objVendor.VendorID = $("#ddlVenderName").val();
    objVendor.VendorName = $("#ddlVenderName").text;
    objVendor.CabNumberFirst = $("#txtcabnofirst").val();
    objVendor.CabNumberLast = $("#txtcabnolast").val();
    objVendor.CabType = $("#ddlcabtype").val();
    objVendor.CabCapacity = $("#ddlcarcapacity").val();
    objVendor.DriverName = $("#txtdrivername").val();
    objVendor.EmpanelDate = $("#txtEmpanelDate").val();
    objVendor.IsActiveComment = $("#txtComment").val();
    var property = [];
             
    for (i = 0; i < counter; i++) {
                 
        var PropID = $('#hdPropertyId' + i).val();
        var PropExpDate = $('#chklistitem_text' + i).val();
                 
        property.push(new CabProperty(PropID, PropExpDate));
        if (PropExpDate!='')
        {
            objVendor.DocumentsVerified = 'true';
            objVendor.IsActive = 'true';
        }
               

    }
    objVendor.lstCabProperty = property;
          
    $.ajax({
        type: "Post",
        url: "CabManagement.aspx/InsertCabDetail",
        data: "{'cabManagement':" + JSON.stringify(objVendor) + "}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (result) {
            var msg = result.d;
            if (msg) {
                $('#popup').hide();
                $('#overlay-back').fadeOut(100);
                ClearCabDetail();
                GetCabDetail();
            }
            else {
                         
            }

        },
        error: function (er) {
                    
            alert(er);
        }
                 
    })
}
           
function ClearCabDetail()
{
    $("#txtcabnofirst").val("");
    $("#txtcabnolast").val("");
    $("#txtdrivername").val("");
    $("#txtEmpanelDate").val("");
    $("#txtComment").val("");
    for (i = 0; i < counter; i++) {

             
        var PropExpDate = $('#chklistitem_text' + i).val();

                
        if (PropExpDate != '') {
            $('#chklistitem_text' + i).val("");
        }


    }
}
function GetCabDetail()
{
    $.ajax({
        type: "POST",
        url: "CabManagement.aspx/GetCabDetail",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result)
        {
            var cabDetail = result.d;
                     
            $("#tblLstCabDetail").dataTable({
                destroy: true,
                paging: true,
                "bStateSave": true,
                "data": cabDetail,
                "aoColumns": [
                   {
                       "data": "CabId", "bSortable": false, render: function (data, type, row) {
                           return "<input id='chk" + data + "' type='checkbox'/>";
                       }
                   },
                  { "data": "VendorName" },
                  { "data": "CabNumberFirst" },
                  { "data": "CabNumberLast" },
                  { "data": "CabType" },
                  { "data": "CabCapacity" },
                  { "data": "DriverName" },
                  { "data": "EmpanelDate" },
                  { "data": "IsActive" },
                  //{"data":"IsActiveComment"},
                  { "data": "DocumentsVerified" },
                           
                {
                    "data": "CabId", "bSortable": false, render: function (data, type, row) {
                        return "<a id='" + data + "' href='#' onClick='EditCabDetail(this)'>Edit</a>";
                    }
                }
                        

                ]


            })

        }


    })



}

function EditCabDetail(e) {
            
    //hide validation message if any
    $("#frmcabdetail").validationEngine('hideAll');
    //hide submit button and show Update button
    $("#btnSubmit").hide();
    $("#btnUpdate").show();
          
    var vall = e.attributes["id"].value;
    // $("#hdnCabId").text(e.attributes["id"].value);
    $("#hdnCabId").text(vall);
    //get parent row
    var row = $(e).parent().parent();
    var tdVendorName = row[0].cells[1].innerText;//VendorName    //index 0 for checkbox
    var tdCabNumberFirst = row[0].cells[2].innerText;//CabNumberFirst
    var tdCabNumberLast = row[0].cells[3].innerText;//CabNumberLast
    var tdCabType = row[0].cells[4].innerText;//CabType
    var tdCabCapacity = row[0].cells[5].innerText;//CabCapacity
    var tdDriverName = row[0].cells[6].innerText;//DriverName
    var tdEmpanelDate = row[0].cells[7].innerText;//EmPanelDate
    var tdIsActive = row[0].cells[8].innerText;//IsActive
    var tdIsActiveComment = row[0].cells[9].innerText;//IsActiveComment
    var tdDocumnetVarified = row[0].cells[10].innerText;//DocumnetsVerified


    $('#overlay-back').fadeIn(100, function () {
        $('#popup').show();
    });


    //set ddl for Vendor Name
    $("#ddlVenderName option").each(function () {
        if ($(this).text().trim() == tdVendorName.trim()) {
            $(this).attr('selected', 'selected');
        }
    });
    $("#txtcabnofirst").val(tdCabNumberFirst);
    $("#txtcabnolast").val(tdCabNumberLast);
           
    $("#txtEmpanelDate").val(tdEmpanelDate);
            
    //set ddl For Cab Type
    $("#ddlcabtype option").each(function () {
        if ($(this).text().trim() == tdCabType.trim()) {
            $(this).attr('selected', 'selected');
        }
    });
    //set ddl For Cab Capacity
    $("#ddlcabtype option").each(function () {
        if ($(this).text().trim() == tdCabCapacity.trim()) {
            $(this).attr('selected', 'selected');
        }
    });

    $("#txtdrivername").val(tdDriverName);
    $("#txtEmpanelDate").val(tdEmpanelDate);
    $("#txtComment").val(tdIsActiveComment);
    GetCabVerificationDetail(vall);

}

function GetCabVerificationDetail( cabid)
{
            
    $.ajax({
        type: "POST",
        url: "CabManagement.aspx/GetCabVerificationDetail",
        data: "{'CabId':'" + cabid + "','Comment':''}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            var msg = result.d;
                   
            if (msg!=null) {
                         
                var dcJSON = msg;
                if (dcJSON != null) {
                    $.each(dcJSON, function (index, value) {
                        $('#chklistitem_text' + index).val(value.ExpiryDate);
                    });
                }
            }
            else {
                alert("Error Occured");
            }

        },
        error: function (er) {
            alert(er);
        }
    })

}
         
