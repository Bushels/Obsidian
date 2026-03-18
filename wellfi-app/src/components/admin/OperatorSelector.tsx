import { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase';

interface Operator {
  id: string;
  slug: string;
  display_name: string;
}

interface OperatorSelectorProps {
  selectedSlug: string | null;
  onSelect: (slug: string | null) => void;
}

export default function OperatorSelector({ selectedSlug, onSelect }: OperatorSelectorProps) {
  const [operators, setOperators] = useState<Operator[]>([]);

  useEffect(() => {
    supabase
      .from('operators' as never)
      .select('id, slug, display_name')
      .eq('status', 'active')
      .order('display_name')
      .then(({ data }) => {
        if (data) setOperators(data as unknown as Operator[]);
      });
  }, []);

  return (
    <select
      value={selectedSlug ?? '__all__'}
      onChange={(e) => onSelect(e.target.value === '__all__' ? null : e.target.value)}
      className="text-xs rounded px-2 py-1.5 border bg-black/40 text-gray-300 border-white/10 backdrop-blur focus:outline-none focus:ring-1 focus:ring-cyan-500/30"
    >
      <option value="__all__">All Operators</option>
      {operators.map((op) => (
        <option key={op.id} value={op.slug}>{op.display_name}</option>
      ))}
    </select>
  );
}
