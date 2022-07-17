export interface Snomad {
  items: SnomadItem[];
}

export interface SnomadItem {
  local: boolean
  active: boolean
  name: string
  code: string
  terminology: string
  sufficientlyDefined: boolean
}
