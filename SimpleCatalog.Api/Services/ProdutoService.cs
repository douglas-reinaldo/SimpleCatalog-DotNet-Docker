namespace SimpleCatalog.Api.Services;
public record ProdutoDTO(string Nome, decimal Preco);

public class ProdutoService
{
    public List<ProdutoDTO> ListarParaVenda()
    {
        // Simulação de dados brutos (vêm do banco)
        var bancoDeDados = new[]
        {
            new { Nome = "Notebook Pro", PrecoVenda = 4500.00m, PrecoCusto = 3000.00m },
            new { Nome = "Mouse Gamer", PrecoVenda = 150.00m, PrecoCusto = 50.00m }
        };

        // Projetando apenas o que o usuário deve ver
        return bancoDeDados
            .Select(p => new ProdutoDTO(p.Nome, p.PrecoVenda))
            .ToList();
    }
}

