program DFS;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Generics.Collections,
  TreeGraph in 'TreeGraph.pas';

procedure PrintVisiteList(AVisitedList: TList<Boolean>);
var B: Boolean;
begin

  for B in AVisitedList do
    Write(Integer(B), ' ');

  Writeln;
end;

var G: TTreeGraph;
    DataList: TList<Integer>;
    N: Integer;
    i: Integer;
    B: Boolean;
begin

  N := 12;

  DataList := TList<Integer>.Create;

  G := TTreeGraph.Create(N);

  G.Add(0, 1);
  G.Add(0, 3);
  G.Add(1, 2);
  G.Add(1, 4);
  G.Add(2, 5);
  G.Add(6, 5);
//  G.Add(5, 6);
  G.Add(6, 7);
  G.Add(6, 11);
  G.Add(7, 8);
  G.Add(7, 9);
  G.Add(8, 10);

  Writeln('-- DFS --');
  for i := 0 to G.VisitedList.Count - 1 do
    begin
      if not G.VisitedList[i] then
        begin
          G.DFS(i, DataList);
          PrintVisiteList(G.VisitedList);
        end;
    end;

  G.Reset;

  Writeln;
  Writeln('-- BFS --');

  for i := 0 to G.VisitedList.Count - 1 do
    begin
      if not G.VisitedList[i] then
        begin
          G.BFS(i, DataList);
          PrintVisiteList(G.VisitedList);
        end;
    end;

  FreeAndNil(G);
  FreeAndNil(DataList);

  Readln;

end.
