state ("Gw") {}

init
{
    vars.scanTarget = new SigScanTarget(0xd, "6A 2C 50 E8 ?? ?? ?? ?? 83 C4 08 C7");
    var scanner = new SignatureScanner(game, game.MainModule.BaseAddress, (int)game.MainModule.ModuleMemorySize);
    IntPtr ptr = scanner.Scan(vars.scanTarget);
    vars.watchers = new MemoryWatcherList();
    vars.watchers.Add(new MemoryWatcher<Int32>(new DeepPointer(ptr, 0x4)) { Name = "instanceType" });
}

update
{
    vars.watchers.UpdateAll(game);
}

isLoading
{
    bool is_outpost = vars.watchers["instanceType"].Current == 0;
    bool is_explorable = vars.watchers["instanceType"].Current == 1;
    return !is_outpost && !is_explorable;
}
