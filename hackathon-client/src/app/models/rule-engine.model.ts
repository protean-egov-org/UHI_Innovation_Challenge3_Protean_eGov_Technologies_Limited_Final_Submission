export interface RuleEngine {
  advicesDetails: MasterData[];
  medicinesDetails: MasterData[];
}

export interface MasterData {
  id: number;
  name: string;
}
