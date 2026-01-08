using SimpleCatalog.Api.Services;
using Xunit;

public class ProdutoServiceTests
{
    [Fact]
    public void ListarParaVenda_DeveRetornarProdutos()
    {
        // Arrange
        var service = new ProdutoService();

        // Act
        var resultado = service.ListarParaVenda();

        // Assert
        Assert.NotNull(resultado);
        Assert.NotEmpty(resultado);
        Assert.Equal(1, resultado.Count);
    }
}
