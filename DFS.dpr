program DFS;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, Generics.Collections;

type

  TGraph = class
    private
      FSize: Integer;
      FList: TList<TList<Integer>>;
    public
      constructor Create(ASize: Integer);
      destructor Destroy; override;

      procedure Add(AId: Integer; AEdge: Integer);

      procedure DFS(AStartEdge: Integer; AVisitedList: TList<Boolean>);
      procedure BFS(AStartEdge: Integer; AVisitedList: TList<Boolean>);
  end;

{ TGraph }

constructor TGraph.Create(ASize: Integer);
var i: Integer;
    L: TList<Integer>;
begin
  FSize := ASize;
  FList := TList<TList<Integer>>.Create;

  for i := 0 to ASize - 1 do
    begin
      L := TList<Integer>.Create;
      FList.Add(L);
    end;
end;

destructor TGraph.Destroy;
begin

  FreeAndNil(FList);

  inherited;
end;

procedure TGraph.Add(AId, AEdge: Integer);
begin
  FList[AId].Add(AEdge);
end;

procedure TGraph.DFS(AStartEdge: Integer; AVisitedList: TList<Boolean>);
var Stack: TStack<Integer>;
    S, Q: Integer;
begin

  Stack := TStack<Integer>.Create;
  Stack.Push(AStartEdge);

  while Stack.Count > 0 do
    begin
      S := Stack.Pop;

      if not AVisitedList[S] then
        begin
          Write(S, ' ');
          AVisitedList[S] := True;
        end;

      for Q in FList[S] do
        begin
          if not AVisitedList[Q] then
            Stack.Push(Q);
        end;

    end;

  Writeln;

  FreeAndNil(Stack);
end;

procedure TGraph.BFS(AStartEdge: Integer; AVisitedList: TList<Boolean>);
var Queue: TQueue<Integer>;
    S, Q: Integer;
begin

  Queue := TQueue<Integer>.Create;
  Queue.Enqueue(AStartEdge);

  AVisitedList[AStartEdge] := True;

  while Queue.Count > 0 do
    begin
      S := Queue.Dequeue;
      Write(S, ' ');

      for Q in FList[S] do
        begin
          if not AVisitedList[Q] then
            begin
              AVisitedList[Q] := True;
              Queue.Enqueue(Q);
            end;
        end;

    end;

  Writeln;

  FreeAndNil(Queue);

end;

procedure PrintVisiteList(AVisitedList: TList<Boolean>);
var B: Boolean;
begin

  for B in AVisitedList do
    Write(Integer(B), ' ');

  Writeln;

end;

var G: TGraph;
    VisitedList: TList<Boolean>;
    N: Integer;
    i: Integer;
    B: Boolean;
begin

  N := 12;

  VisitedList := TList<Boolean>.Create;

  for i := 1 to N do
    begin
      VisitedList.Add(False);
    end;

  PrintVisiteList(VisitedList);

  G := TGraph.Create(N);

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
  for i := 0 to VisitedList.Count - 1 do
    begin
      if not VisitedList[i] then
        begin
          G.DFS(i, VisitedList);
          PrintVisiteList(VisitedList);
        end;
    end;

  for i := 0 to N - 1 do
    begin
      VisitedList[i] := False;
    end;

  Writeln;
  Writeln('-- BFS --');

  for i := 0 to VisitedList.Count - 1 do
    begin
      if not VisitedList[i] then
        begin
          G.BFS(i, VisitedList);
          PrintVisiteList(VisitedList);
        end;
    end;

  FreeAndNil(G);
  FreeAndNil(VisitedList);

  Readln;

end.
