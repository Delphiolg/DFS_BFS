unit TreeGraph;

interface
uses

  System.SysUtils,
  Generics.Collections;

type

  TTreeGraph = class
    private
      FSize: Integer;
      FList: TList<TList<Integer>>;

      FVisitedList: TList<Boolean>;
    public
      constructor Create(ASize: Integer);
      destructor Destroy; override;

      procedure Add(AId: Integer; AEdge: Integer);

      procedure DFS(AStartEdge: Integer; AIndexes: TList<Integer>);
      procedure BFS(AStartEdge: Integer; AIndexes: TList<Integer>);

      procedure Reset;

      property VisitedList: TList<Boolean> read FVisitedList;
  end;

implementation

{ TTreeGraph }

constructor TTreeGraph.Create(ASize: Integer);
var i: Integer;
    L: TList<Integer>;
begin
  FSize := ASize;
  FList := TList<TList<Integer>>.Create;
  FVisitedList := TList<Boolean>.Create;

  for i := 0 to ASize - 1 do
    begin
      L := TList<Integer>.Create;
      FList.Add(L);

      FVisitedList.Add(False);
    end;
end;

destructor TTreeGraph.Destroy;
begin

  FreeAndNil(FList);

  inherited;
end;

procedure TTreeGraph.Add(AId, AEdge: Integer);
begin
  FList[AId].Add(AEdge);
end;

procedure TTreeGraph.DFS(AStartEdge: Integer; AIndexes: TList<Integer>);
var Stack: TStack<Integer>;
    S, Q: Integer;
begin

  Stack := TStack<Integer>.Create;
  Stack.Push(AStartEdge);

  while Stack.Count > 0 do
    begin
      S := Stack.Pop;

      if not FVisitedList[S] then
        begin
          Write(S, ' ');
          AIndexes.Add(S);
          FVisitedList[S] := True;
        end;

      for Q in FList[S] do
        begin
          if not FVisitedList[Q] then
            Stack.Push(Q);
        end;

    end;

  Writeln;

  FreeAndNil(Stack);
end;


procedure TTreeGraph.BFS(AStartEdge: Integer; AIndexes: TList<Integer>);
var Queue: TQueue<Integer>;
    S, Q: Integer;
begin

  Queue := TQueue<Integer>.Create;
  Queue.Enqueue(AStartEdge);

  FVisitedList[AStartEdge] := True;

  while Queue.Count > 0 do
    begin
      S := Queue.Dequeue;
      Write(S, ' ');
      AIndexes.Add(S);

      for Q in FList[S] do
        begin
          if not FVisitedList[Q] then
            begin
              FVisitedList[Q] := True;
              Queue.Enqueue(Q);
            end;
        end;

    end;

  Writeln;

  FreeAndNil(Queue);

end;

procedure TTreeGraph.Reset;
var i: Integer;
begin
  for i := 0 to FVisitedList.Count - 1 do
    FVisitedList[i] := False;
end;

end.