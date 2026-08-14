using Microsoft.AspNetCore.Mvc;
using static CreatePassingOrderCommand;
using static UpdatePassingOrderCommand;
[ApiController]
[Route("api/[Controller]s")]
public class PassingOrderController : ControllerBase
{
    private readonly IUserDbContext _context;

    public PassingOrderController(IUserDbContext context)
    {
        _context = context;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody]CreatePassingOrderModel model)
    {
        CreatePassingOrderCommand vm = new CreatePassingOrderCommand(_context,model);
        await vm.Handle();
        return Ok();
    }
    [HttpPut("{id}")]
    public async Task<IActionResult> Update([FromBody]UpdatePassingOrderModel model,int id)
    {
        UpdatePassingOrderCommand vm = new UpdatePassingOrderCommand(_context,model,id);
        await vm.Handle();
        return Ok();
    }
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        DeletPassingOrderCommand vm = new DeletPassingOrderCommand(_context,id);
        await vm.Handle();
        return Ok();
    }
    [HttpGet("{id}")]
    public async Task<IActionResult> Get(int id)
    {
        GetPassingOrderQuery vm = new GetPassingOrderQuery(_context,id);
        return Ok(await vm.Handle());
    }
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        GetAllPassingOrderQuery vm = new GetAllPassingOrderQuery(_context);
        return Ok(await vm.Handle());
    }
}