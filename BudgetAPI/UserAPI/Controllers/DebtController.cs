using Microsoft.AspNetCore.Mvc;
[ApiController]
[Route("/api/[Controller]s")]
public class DebtController : ControllerBase
{
    private readonly IUserDbContext _context;

    public DebtController(IUserDbContext context)
    {
        _context = context;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateDebtModel model)
    {
        CreateDebtCommand vm = new CreateDebtCommand(_context,model);
        await vm.Handle();
        return Ok();
    }    

    [HttpPut("{id}")]
    public async Task<IActionResult> Update([FromBody]UpdateDebtModel model,int id)
    {
        UpdateDebtCommand vm = new UpdateDebtCommand(_context,model,id);
        await vm.Handle();
        return Ok();
    }

    [HttpPut("/pay/{id}")]
    public async Task<IActionResult> Pay(int id)
    {
        PayDebtCommand vm = new PayDebtCommand(_context,id);
        await vm.Handle();
        return Ok();        
    }
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        DeleteDebtCommand vm = new DeleteDebtCommand(_context,id);
        await vm.Handle();
        return Ok();
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> Get(int id)
    {
        GetDebtQuery vm = new GetDebtQuery(_context,id);
        return Ok(await vm.Handle());
    }
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        GetAllDebtQuery vm = new GetAllDebtQuery(_context);
        return Ok(await vm.Handle());
    }

}