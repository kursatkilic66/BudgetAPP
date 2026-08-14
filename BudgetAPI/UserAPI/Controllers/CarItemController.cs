using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("/api/[Controller]s")]
public class CarItemController : ControllerBase
{
    private readonly IUserDbContext _context;

    public CarItemController(IUserDbContext context)
    {
        _context = context;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody]CreateCarItemModel model)
    {
        CreateCarItemCommand vm = new CreateCarItemCommand(_context,model);
        await vm.Handle();
        return Ok();
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> Get(int id)
    {
        GetCarItemQuery vm = new GetCarItemQuery(_context,id);
        return Ok(await vm.Handle());
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update([FromBody]UpdateCarItemModel model,int id)
    {
        UpdateCarItemCommand vm = new UpdateCarItemCommand(_context,model,id);
        await vm.Handle();
        return Ok();
    } 
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        GetAllCarItemQuery vm = new GetAllCarItemQuery(_context);
        return Ok(await vm.Handle());
    }
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        DeleteCarItemCommand vm = new DeleteCarItemCommand(_context,id);
        await vm.Handle();
        return Ok();
    }

}