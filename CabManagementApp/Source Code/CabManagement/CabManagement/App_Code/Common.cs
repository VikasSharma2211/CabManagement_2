using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.DirectoryServices;
using System.IO;
using System.Configuration;
using System.Globalization;
using System.Text;

namespace Infosys.CabManagement.UI
{
    public class Common
    {
        // For Getting Current User Name Login
        public string GetCurrentUserName()
        {
            string UserName = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
            //string UserName = System.Web.HttpContext.Current.User.Identity.Name.Substring(11);
            UserName = UserName.Substring(UserName.LastIndexOf("\\") + 1);
            return UserName;
        }

        public static Dictionary<string, string> GetUserDetails(string EmailId, string domainName)
        {
            Dictionary<string, string> usrDetails = new Dictionary<string, string>();                
            try
            {   
                string filter = string.Format("(&(ObjectClass={0})(sAMAccountName={1}))", "person", EmailId);
                string[] properties = new string[] { "fullname" };
                DirectoryEntry adRoot = new DirectoryEntry("LDAP://" + domainName, null, null, AuthenticationTypes.Secure);
                DirectorySearcher searcher = new DirectorySearcher(adRoot);
                searcher.SearchScope = SearchScope.Subtree;
                searcher.ReferralChasing = ReferralChasingOption.All;
                searcher.PropertiesToLoad.AddRange(properties);
                searcher.Filter = filter;
                SearchResult result = searcher.FindOne();
                DirectoryEntry directoryEntry = result.GetDirectoryEntry();
                usrDetails.Add("EmailId", directoryEntry.Properties["mail"][0].ToString()); 
                string info = directoryEntry.Properties["info"][0].ToString();
                if (info.Contains(";"))
                    usrDetails.Add("ProjectCode", getBetween(info, "- ", ";"));
                else
                    usrDetails.Add("ProjectCode", getBetween(info, "- ", ")"));
                string mobileNum = directoryEntry.Properties["mobile"][0].ToString();
                if (mobileNum.ToString().Contains(' '))
                {
                    usrDetails.Add("Mobile",mobileNum.ToString().Split(' ')[1]);
                }
                else
                {
                    usrDetails.Add("Mobile",mobileNum.ToString());
                }                
                
                DirectoryEntry managerDE = new DirectoryEntry("LDAP://" + directoryEntry.Properties["manager"][0].ToString());
                if (managerDE != null)               
                {
                    usrDetails.Add("Manager",(managerDE.Properties["mail"].Value.ToString().Split('@'))[0]);
                }

                //string EmpNo = directoryEntry.Properties["description"][0].ToString();
                //if (EmpNo.Contains(','))
                //{
                //    Session["EmployeeNumber"] = Convert.ToInt32(EmpNo.Split(',')[0]);
                //}
                //else
                //{
                //    Session["EmployeeNumber"] = Convert.ToInt32(EmpNo);
                //}
            }
            catch (Exception)
            {

            }
            return usrDetails;
        }

        public static string getBetween(string strSource, string strStart, string strEnd)
        {
            int Start, End;
            if (strSource.Contains(strStart) && strSource.Contains(strEnd))
            {
                Start = strSource.IndexOf(strStart, 0) + strStart.Length;
                End = strSource.IndexOf(strEnd, Start);
                return strSource.Substring(Start, End - Start);
            }
            else
            {
                return "";
            }
        }



        public static void getDirectoryContacts()
        {

           
           string domainNamee= ConfigurationManager.AppSettings["LDAP_Path"];
           DirectoryEntry entry = new DirectoryEntry("LDAP://" + domainNamee, null, null, AuthenticationTypes.Secure);
           DirectorySearcher searcher = new DirectorySearcher(entry);
             string employeee="";
           
            foreach (SearchResult sResultSet in searcher.FindAll())
            {


               employeee= GetProperty(sResultSet, "name");
                employeee = sResultSet.Properties["name"][0].ToString();
                
             

            }
        }

        public static string GetProperty(SearchResult searchResult, 
 string PropertyName)
  {
   if(searchResult.Properties.Contains(PropertyName))
   {
    return searchResult.Properties[PropertyName][0].ToString() ;
   }
   else
   {
    return string.Empty;
   }
  }

        /// Handles error by accepting the error message
        /// Displays the page on which the error occured
        public static void WriteError(Exception ex)
        {
            try
            {
                string path = ConfigurationManager.AppSettings["LogPath"] + DateTime.Today.ToString("dd-MM-yyyy") + ".txt";
                if (!File.Exists(System.Web.HttpContext.Current.Server.MapPath(path)))
                {
                    File.Create(System.Web.HttpContext.Current.Server.MapPath(path)).Close();
                }
                using (StreamWriter w = File.AppendText(System.Web.HttpContext.Current.Server.MapPath(path)))
                {
                    w.WriteLine("\r\nLog Entry : ");
                    w.WriteLine("{0}", DateTime.Now.ToString(CultureInfo.InvariantCulture));
                    StringBuilder err = new StringBuilder();
                    err.Append("Source:" + ex.Source + "\n");
                    err.Append("StackTrace:" + ex.StackTrace + "\n");

                    err.Append("Error in: " + System.Web.HttpContext.Current.Request.Url.ToString() + "\n");
                    err.Append("Error Message:" + ex.Message + "\n");
                    w.WriteLine(err.ToString());
                    w.WriteLine("_________________________________________________________");
                    w.Flush();
                    w.Close();
                    
                }
            }
            catch (Exception e)
            {
                throw;
            }

        }
    }
}