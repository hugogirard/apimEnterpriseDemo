using CustomIdp.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Security.Claims;

namespace CustomIdp.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        private readonly IApiGatewayService _apiGatewayService;
        private readonly IConfiguration _configuration;

        public HomeController(ILogger<HomeController> logger,
                              IApiGatewayService apiGatewayService,
                              IConfiguration configuration)
        {
            _logger = logger;
            _apiGatewayService = apiGatewayService;
            _configuration = configuration;
        }

        public async Task<IActionResult> Index()
        {
            return View();
        }

        public async Task<IActionResult> RedirectToDevPortal() 
        {
            if (User.Identity != null && User.Identity.IsAuthenticated) 
            {
                var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
                string redirectUrl = await _apiGatewayService.GetRedirectionUrlAsync(userId);

                if (string.IsNullOrEmpty(redirectUrl))
                    return RedirectToAction("Index", "Account");

                return Redirect(redirectUrl);
            }

            return RedirectToAction("Index", "Account");
        }

        public async Task<IActionResult> Delegate([FromQuery(Name = "returnUrl")] string returnUrl,
                                                  [FromQuery(Name = "sig")]string sig,
                                                  [FromQuery(Name = "salt")]string salt,
                                                  [FromQuery(Name = "operation")]string operation)
        {

            if (operation == "SignOut")
                return Redirect($"~/Identity/Account/Logout?returnUrl={_configuration["Apim:DevPortal"]}&externalWebsite=true");

            bool isValid = _apiGatewayService.ValidateSignature(sig, operation, salt, returnUrl);

            if (isValid)                                
            {
                if (operation == "SignIn") 
                {
                    if (User.Identity == null || !User.Identity.IsAuthenticated)
                    {
                        return Redirect($"~/Identity/Account/Login?returnUrl=~/Home/RedirectToDevPortal");
                    }

                    var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
                    string redirectUrl = await _apiGatewayService.GetRedirectionUrlAsync(userId);

                    return Redirect(redirectUrl);
                }
                else 
                {
                    return Redirect($"~/Identity/Account/Register?returnUrl=~/Home/RedirectToDevPortal");
                }
            }
            else
            {
                ViewBag.Message = "Signature validation failed";
                return View();
            }
            
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}