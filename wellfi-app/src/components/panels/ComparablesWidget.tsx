import React, { useState, useEffect } from 'react';
import { AreaChart, Area, XAxis, YAxis, Tooltip, ResponsiveContainer } from 'recharts';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Activity, TrendingUp, Sparkles, ChevronRight, CheckCircle2 } from 'lucide-react';
import { Button } from '@/components/ui/button';

export function ComparablesWidget({ onDeploy }: { onDeploy: () => void }) {
  const [activeTab, setActiveTab] = useState<'life' | 'production'>('life');
  const [animateIn, setAnimateIn] = useState(false);

  useEffect(() => {
    // Staggered animation entrance
    const timer = setTimeout(() => setAnimateIn(true), 100);
    return () => clearTimeout(timer);
  }, []);

  // Mock comparison data
  const data = [
    { month: 'M1', standard: 100, wellfi: 100 },
    { month: 'M6', standard: 85, wellfi: 95 },
    { month: 'M12', standard: 60, wellfi: 88 },
    { month: 'M14', standard: 45, wellfi: 82 },
    { month: 'M18', standard: 10, wellfi: 75 },
    { month: 'M24', standard: 0, wellfi: 60 },
  ];

  return (
    <Card className="bg-gradient-to-b from-[#0B1525] to-[#0A0F1E] border-wellfi-cyan/20 overflow-hidden relative group">
      {/* Premium ambient glow */}
      <div className="absolute top-0 inset-x-0 h-[1px] bg-gradient-to-r from-transparent via-wellfi-cyan/40 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-700" />
      <div className="absolute top-0 right-0 w-32 h-32 bg-wellfi-cyan/5 rounded-full blur-[40px] pointer-events-none" />

      <CardHeader className="pb-2 pt-5 select-none">
        <div className="flex items-center gap-2 mb-1">
          <Sparkles className="w-4 h-4 text-wellfi-cyan animate-pulse" />
          <p className="text-[10px] tracking-widest uppercase text-wellfi-cyan font-mono font-semibold">
            Network Intelligence
          </p>
        </div>
        <CardTitle className="text-lg font-syne text-white flex items-center justify-between">
          ROI Projection
          <Badge variant="outline" className="bg-[#111A2B] border-wellfi-cyan/20 text-wellfi-cyan text-xs font-mono">
            +57% Expected
          </Badge>
        </CardTitle>
      </CardHeader>

      <CardContent className="space-y-5 px-5 pb-5 pt-0">
        {/* Toggle standard vs wellfi */}
        <div className="flex bg-[#0A0F1E] p-1 rounded-lg border border-white/5 relative z-10">
          <button
            onClick={() => setActiveTab('life')}
            className={`flex-1 text-xs font-medium py-1.5 rounded-md transition-all duration-300 ${
              activeTab === 'life' ? 'bg-[#1A253A] text-white shadow-sm' : 'text-gray-400 hover:text-gray-200'
            }`}
          >
            Pump Life
          </button>
          <button
            onClick={() => setActiveTab('production')}
            className={`flex-1 text-xs font-medium py-1.5 rounded-md transition-all duration-300 ${
              activeTab === 'production' ? 'bg-[#1A253A] text-white shadow-sm' : 'text-gray-400 hover:text-gray-200'
            }`}
          >
            Production
          </button>
        </div>

        {/* Stats Grid */}
        <div className={`grid grid-cols-2 gap-3 transition-all duration-700 ease-out transform ${animateIn ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'}`}>
          <div className="bg-black/30 rounded-xl p-3 border border-white/5">
            <p className="text-[10px] text-gray-500 font-mono uppercase tracking-wider mb-1">Current</p>
            <div className="flex items-end gap-1.5">
              <span className="text-xl font-syne text-gray-300 font-semibold">{activeTab === 'life' ? '14' : '45'}</span>
              <span className="text-xs text-gray-600 font-mono pb-0.5">{activeTab === 'life' ? 'mo avg' : 'bbl/d'}</span>
            </div>
          </div>
          <div className="bg-wellfi-cyan/10 rounded-xl p-3 border border-wellfi-cyan/20 relative overflow-hidden">
            <div className="absolute inset-0 bg-gradient-to-tr from-wellfi-cyan/5 to-transparent pointer-events-none" />
            <p className="text-[10px] text-wellfi-cyan/70 font-mono uppercase tracking-wider mb-1 relative z-10 text-nowrap">With WellFi</p>
            <div className="flex items-end gap-1.5 relative z-10">
              <span className="text-xl font-syne text-white font-bold">{activeTab === 'life' ? '22' : '65'}</span>
              <span className="text-xs text-wellfi-cyan/60 font-mono pb-0.5">{activeTab === 'life' ? 'mo est' : 'bbl/d'}</span>
            </div>
          </div>
        </div>

        {/* Mini Chart */}
        <div className={`h-28 w-full transition-all duration-700 delay-100 ease-out transform ${animateIn ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'}`}>
          <ResponsiveContainer width="100%" height="100%">
            <AreaChart data={data} margin={{ top: 5, right: 0, left: 0, bottom: 0 }}>
              <defs>
                <linearGradient id="colorWellFi" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="5%" stopColor="#00D4FF" stopOpacity={0.3}/>
                  <stop offset="95%" stopColor="#00D4FF" stopOpacity={0}/>
                </linearGradient>
                <linearGradient id="colorStd" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="5%" stopColor="#6B7280" stopOpacity={0.1}/>
                  <stop offset="95%" stopColor="#6B7280" stopOpacity={0}/>
                </linearGradient>
              </defs>
              <Tooltip 
                contentStyle={{ backgroundColor: '#0B1525', border: '1px solid rgba(255,255,255,0.1)', borderRadius: '8px' }}
                itemStyle={{ color: '#fff', fontSize: '12px', fontFamily: 'monospace' }}
                labelStyle={{ color: '#888', fontSize: '12px' }}
              />
              <Area type="monotone" dataKey="wellfi" stroke="#00D4FF" strokeWidth={2} fillOpacity={1} fill="url(#colorWellFi)" />
              <Area type="monotone" dataKey="standard" stroke="#6B7280" strokeWidth={1} strokeDasharray="3 3" fillOpacity={1} fill="url(#colorStd)" />
            </AreaChart>
          </ResponsiveContainer>
        </div>

        {/* Comparison bullets */}
        <div className={`space-y-2 pt-1 transition-all duration-700 delay-200 ease-out transform ${animateIn ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'}`}>
          <div className="flex items-start gap-2">
            <CheckCircle2 className="w-3.5 h-3.5 text-wellfi-cyan mt-0.5 shrink-0" />
            <p className="text-xs text-gray-400 leading-relaxed">
              Based on <span className="text-gray-200">12</span> comparable wells within a 15km radius in the same formation.
            </p>
          </div>
          <div className="flex items-start gap-2">
            <CheckCircle2 className="w-3.5 h-3.5 text-wellfi-cyan mt-0.5 shrink-0" />
            <p className="text-xs text-gray-400 leading-relaxed">
              Eliminate premature pump failures with AI-driven predictive insights.
            </p>
          </div>
        </div>

        {/* CTA */}
        <Button 
          onClick={onDeploy}
          className="w-full h-11 bg-wellfi-cyan hover:bg-wellfi-cyan/90 text-black font-semibold rounded-xl group overflow-hidden relative shadow-[0_0_20px_rgba(0,212,255,0.15)] hover:shadow-[0_0_25px_rgba(0,212,255,0.3)] transition-all duration-300"
        >
          <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent -translate-x-[150%] group-hover:translate-x-[150%] transition-transform duration-700 ease-out" />
          <span className="flex items-center gap-2">
            <Activity className="w-4 h-4" />
            Request WellFi Deploy
            <ChevronRight className="w-4 h-4 ml-1 opacity-60 group-hover:translate-x-1 transition-transform" />
          </span>
        </Button>
      </CardContent>
    </Card>
  );
}
