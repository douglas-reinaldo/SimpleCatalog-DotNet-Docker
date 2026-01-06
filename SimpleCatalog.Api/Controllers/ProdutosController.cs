using Microsoft.AspNetCore.Mvc;
using SimpleCatalog.Api.Services;
namespace SimpleCatalog.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ProdutosController : ControllerBase
{
    private readonly ProdutoService _service;

    public ProdutosController()
    {
        _service = new ProdutoService(); // Simplificado: sem Injeção de Dependência por agora
    }

    [HttpGet]
    public IActionResult Get()
    {
        var produtos = _service.ListarParaVenda();
        return Ok(produtos);
    }
}