using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Infosys.CabManagement.Business;
using Infosys.CabManagement.Model;


namespace Infosys.CabManagement.UI
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    Int32 RoleId;
                    string UserName = string.Empty;
                    if (Session["RoleId"] == null)
                    {
                        Common objCommon = new Common();
                        UserName = objCommon.GetCurrentUserName();
                        using (RoleManagementBLL objRoleManagementBLL = new RoleManagementBLL())
                        {
                            RoleId = objRoleManagementBLL.GetRoleId(UserName);
                            Session["RoleId"] = RoleId;
                        }
                    }
                    else
                    {
                        RoleId = Convert.ToInt32(Session["RoleId"]);
                    }
                    switch (RoleId)
                    {
                        case 1:
                            break;
                        case 2:
                            break;
                        case 3:
                            break;
                        default:
                            Response.Redirect("~/Error.aspx");
                            break;
                    }

                }
            }
            catch(Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
        }

        #region Web Methods

        [WebMethod]
        public static List<Shift> GetActiveShiftList()
        {
            List<Shift> lstShift = null;             
            ShiftManagementBLL objShiftManagementBLL = null;
            try 
            {             
             objShiftManagementBLL = new ShiftManagementBLL();
             Shift objShift = new Shift();
             objShift.IsActive = true;
             lstShift = objShiftManagementBLL.GetShiftList(objShift);        
            }
            catch(Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objShiftManagementBLL = null;
            }
            return lstShift;
        }

        [WebMethod]
        public static List<Shift> GetInactiveShiftList()
        {
            List<Shift> lstShift = null;
            ShiftManagementBLL objShiftManagementBLL = null;
            try
            {
                objShiftManagementBLL = new ShiftManagementBLL();
                Shift objShift = new Shift();
                objShift.IsActive = false;
                lstShift = objShiftManagementBLL.GetShiftList(objShift);
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objShiftManagementBLL = null;
            }
            return lstShift;
        }
       
       
        [WebMethod]
        public static string  AddNewShift(Shift shift)
        {
            string OutResult= "";
             ShiftManagementBLL objShiftManagementBLL = null;
            try
            {
                Common objCommon = new Common();
                 objShiftManagementBLL = new ShiftManagementBLL();
                        
              
                //shift.ShiftTime = ddlHour.SelectedValue + ":" + ddlMin.SelectedValue + ":00";
                shift.CreatedDate = Convert.ToDateTime(DateTime.Now.ToString());
                shift.CreatedBy =objCommon.GetCurrentUserName();
                OutResult = objShiftManagementBLL.InsertShift(shift);
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objShiftManagementBLL = null;
            }
            return OutResult;
        }

        [WebMethod]
        public static List<DC> GetDCList()
        {
            List<DC> lstDC = null;
            try
            {
                VendorManagementBLL objVendorManagementBLL = new VendorManagementBLL();
                lstDC = objVendorManagementBLL.GetDCList();
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            return lstDC;
        }

        [WebMethod]
        public static bool DeleteSelectedShift(string shiftIds, bool IsActive)
        {
            bool isFlag = false;
            ShiftManagementBLL objShiftManagementBLL = null;
            try
            {
                Common objCommon = new Common();
                objShiftManagementBLL = new ShiftManagementBLL();
                string ModifiedBy = objCommon.GetCurrentUserName();
                isFlag = objShiftManagementBLL.Active_InactiveShift(shiftIds, IsActive, ModifiedBy);
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objShiftManagementBLL = null;
            }
            return isFlag;
        }

        [WebMethod]
        public static string UpdateShift(Shift shift)
        {
            string isFlag = string.Empty;
            ShiftManagementBLL objShiftManagementBLL = null;
            try
            {
                Common objCommon = new Common();
                objShiftManagementBLL = new ShiftManagementBLL();
                shift.ModifiedBy =objCommon. GetCurrentUserName();
                isFlag = objShiftManagementBLL.UpdateShift(shift);
            }
            catch (Exception ex)
            {
                // Log the error to a text file in the Error folder                
                Common.WriteError(ex);
            }
            finally
            {
                objShiftManagementBLL = null;
            }
            return isFlag;
        }
        
        #endregion

        public static string ShiftIds { get; set; }
    }
}